import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/home/domain/models/order_detail_entity.dart';
import 'package:apo/features/home/presentation/cubits/order_details_cubit.dart';
import 'package:apo/features/home/presentation/cubits/order_details_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        final status = state.status;
        final isReordering = state.reorderStatus.isLoading;
        final canReorder = status is Success<OrderDetailEntity>;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              status.successValue?.jobNumber ?? AppStrings.orderDetails,
            ),
          ),
          bottomNavigationBar: canReorder
              ? SafeArea(
                  minimum: const EdgeInsets.all(Constants.defaultPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isReordering
                          ? () {}
                          : () => context.read<OrderDetailsCubit>().reorder(),
                      child: isReordering
                          ? const CircularProgressIndicator()
                          : Text(AppStrings.reorder),
                    ),
                  ),
                )
              : null,
          body: switch (status) {
            Loading() => const _OrderDetailsLoading(),
            Failure() => Center(
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                child: Text(
                  status.failureMessage,
                  textAlign: TextAlign.center,
                  style: TextStyles.text14400,
                ),
              ),
            ),
            Success(data: final order) => _OrderDetailsContent(order: order),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _OrderDetailsContent extends StatelessWidget {
  const _OrderDetailsContent({required this.order});

  final OrderDetailEntity order;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _OrderHeaderCard(order: order),
          VerticalSpace(16),
          _OrderSummaryCard(order: order),
          VerticalSpace(16),
          Text(AppStrings.orderItems, style: TextStyles.text17500),
          VerticalSpace(12),
          ...order.items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _OrderItemCard(item: item),
            ),
          ),
          if (order.addresses.isNotEmpty) ...[
            VerticalSpace(8),
            Text(AppStrings.shippingAddressTitle, style: TextStyles.text17500),
            VerticalSpace(8),
            _AddressCard(address: _findAddress(order.addresses, 'Shipping')),
            VerticalSpace(12),
            Text(AppStrings.billingAddressTitle, style: TextStyles.text17500),
            VerticalSpace(8),
            _AddressCard(address: _findAddress(order.addresses, 'Billing')),
          ],
          VerticalSpace(24),
        ],
      ),
    );
  }
}

class _OrderHeaderCard extends StatelessWidget {
  const _OrderHeaderCard({required this.order});

  final OrderDetailEntity order;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusLabel = order.status.isEmpty ? 'Submitted' : order.status;
    final shipDate = _formatDate(order.requestedShipDate);
    final created = _formatDate(order.createdAt);
    final poNumber = (order.poNumber ?? '').trim();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(order.jobNumber, style: TextStyles.text18700),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyles.text10500.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          VerticalSpace(12),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _MetaLine(
                icon: Icons.business_outlined,
                label: order.jobOwner.isEmpty ? '-' : order.jobOwner,
              ),
              _MetaLine(
                icon: Icons.receipt_long_outlined,
                label: poNumber.isEmpty ? 'PO: -' : 'PO: $poNumber',
              ),
              _MetaLine(
                icon: Icons.calendar_today_outlined,
                label: shipDate.isEmpty ? '-' : shipDate,
              ),
            ],
          ),
          VerticalSpace(8),
          if (created.isNotEmpty)
            Text(
              'Created $created',
              style: TextStyles.text14400.copyWith(
                color: colorScheme.secondaryText,
              ),
            ),
        ],
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  const _OrderSummaryCard({required this.order});

  final OrderDetailEntity order;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.orderSummary, style: TextStyles.text16700),
          VerticalSpace(12),
          _SummaryRow(label: 'Items', value: order.items.length.toString()),
          VerticalSpace(8),
          _SummaryRow(
            label: 'Subtotal',
            value: _formatCurrency(order.subtotalAmount),
          ),
          VerticalSpace(8),
          _SummaryRow(
            label: 'Discount',
            value: _formatCurrency(order.discountAmount),
          ),
          VerticalSpace(8),
          _SummaryRow(label: 'Tax', value: _formatCurrency(order.taxAmount)),
          VerticalSpace(8),
          _SummaryRow(
            label: 'Shipping',
            value: _formatCurrency(order.shippingAmount),
          ),
          VerticalSpace(12),
          _SummaryRow(
            label: 'Total',
            value: _formatCurrency(order.totalAmount),
            highlight: true,
          ),
          if (order.customerNotes.trim().isNotEmpty) ...[
            VerticalSpace(12),
            Text(
              order.customerNotes,
              style: TextStyles.text14400.copyWith(
                color: colorScheme.secondaryText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _OrderItemCard extends StatelessWidget {
  const _OrderItemCard({required this.item});

  final OrderDetailItemEntity item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: colorScheme.outlineVariant),
            ),
            child: item.imageUrl.isEmpty
                ? const NetworkImagePlaceholder()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) =>
                          const NetworkImagePlaceholder(),
                    ),
                  ),
          ),
          HorizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.productName, style: TextStyles.text14600),
                VerticalSpace(4),
                Text(
                  '${AppStrings.sku}: ${item.productSku.isEmpty ? '-' : item.productSku}',
                  style: TextStyles.text14400.copyWith(
                    color: colorScheme.secondaryText,
                  ),
                ),
                VerticalSpace(4),
                Text(
                  '${item.colorName}${item.sizeName == null || item.sizeName!.isEmpty ? '' : ' • ${item.sizeName}'}',
                  style: TextStyles.text14400.copyWith(
                    color: colorScheme.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          HorizontalSpace(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatCurrency(item.lineTotal),
                style: TextStyles.text14600.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              VerticalSpace(4),
              Text(
                'x${item.quantity}',
                style: TextStyles.text14400.copyWith(
                  color: colorScheme.secondaryText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});

  final OrderDetailAddressEntity address;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address.addressLine1, style: TextStyles.text14400),
          if (address.addressLine2.isNotEmpty)
            Text(address.addressLine2, style: TextStyles.text14400),
          Text(
            '${address.city}, ${address.state} ${address.zipCode}',
            style: TextStyles.text14400,
          ),
          Text(
            address.country,
            style: TextStyles.text14400.copyWith(
              color: colorScheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: colorScheme.secondaryText),
        HorizontalSpace(6),
        Text(
          label,
          style: TextStyles.text14400.copyWith(
            color: colorScheme.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.text14400.copyWith(
            color: colorScheme.secondaryText,
          ),
        ),
        Text(
          value,
          style: TextStyles.text14600.copyWith(
            color: highlight ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _OrderDetailsLoading extends StatelessWidget {
  const _OrderDetailsLoading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LoadingCard(height: 110),
          VerticalSpace(16),
          _LoadingCard(height: 120),
          VerticalSpace(16),
          _LoadingLine(width: 120, height: 18),
          VerticalSpace(12),
          _LoadingCard(height: 90),
          VerticalSpace(12),
          _LoadingCard(height: 90),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ShimmerPlaceholder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

class _LoadingLine extends StatelessWidget {
  const _LoadingLine({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ShimmerPlaceholder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

OrderDetailAddressEntity _findAddress(
  List<OrderDetailAddressEntity> addresses,
  String type,
) {
  return addresses.firstWhere(
    (address) => address.addressType.toLowerCase() == type.toLowerCase(),
    orElse: () => addresses.first,
  );
}

String _formatDate(DateTime? date) {
  if (date == null) return '';
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  final month = months[date.month - 1];
  final day = date.day.toString().padLeft(2, '0');
  return '$month $day, ${date.year}';
}

String _formatCurrency(num value) {
  return '\$${value.toStringAsFixed(2)}';
}
