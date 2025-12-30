import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/home/domain/models/order_entity.dart';
import 'package:apo/features/home/presentation/cubits/orders_cubit.dart';
import 'package:apo/features/home/presentation/cubits/orders_state.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
import 'package:apo/features/home/presentation/cubits/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<ProfileCubit, ProfileState>(
          listenWhen: (previous, current) =>
              previous.isAuthenticated != current.isAuthenticated,
          listener: (context, state) {
            if (state.isAuthenticated) {
              context.read<OrdersCubit>().loadOrders();
            }
          },
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              final isAuthenticated = context.select<ProfileCubit, bool>(
                (cubit) => cubit.state.isAuthenticated,
              );

              if (!isAuthenticated) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Constants.defaultPadding),
                    child: Text(
                      AppStrings.ordersLoginRequired,
                      textAlign: TextAlign.center,
                      style: TextStyles.text14400,
                    ),
                  ),
                );
              }

              if (state.status is Empty<List<OrderEntity>>) {
                context.read<OrdersCubit>().loadOrders();
              }

              final isLoading =
                  state.status.isLoading &&
                  state.items.isEmpty &&
                  !state.isRefreshing;
              final isFailure = state.status.isFailure && state.items.isEmpty;

              if (isLoading) {
                return const _OrdersLoading();
              }

              if (isFailure) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Constants.defaultPadding),
                    child: Text(
                      state.status.failureMessage,
                      textAlign: TextAlign.center,
                      style: TextStyles.text14400,
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () =>
                    context.read<OrdersCubit>().loadOrders(isRefresh: true),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          Constants.defaultPadding,
                          Constants.defaultPadding,
                          Constants.defaultPadding,
                          8,
                        ),
                        child: const _OrdersHeader(),
                      ),
                    ),
                    if (state.items.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text(
                            AppStrings.noOrdersFound,
                            style: TextStyles.text14400,
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constants.defaultPadding,
                        ),
                        sliver: SliverList.separated(
                          itemCount: state.items.length,
                          separatorBuilder: (_, _) => VerticalSpace(12),
                          itemBuilder: (context, index) {
                            final order = state.items[index];
                            return _OrderCard(order: order);
                          },
                        ),
                      ),
                    const SliverToBoxAdapter(child: VerticalSpace(24)),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _OrdersHeader extends StatelessWidget {
  const _OrdersHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.orders, style: TextStyles.text24500),
        VerticalSpace(4),
        Text(
          AppStrings.ordersSubtitle,
          style: TextStyles.text14400.copyWith(
            color: colorScheme.secondaryText,
          ),
        ),
      ],
    );
  }
}

class _OrdersLoading extends StatelessWidget {
  const _OrdersLoading();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.separated(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      itemCount: 6,
      separatorBuilder: (_, _) => VerticalSpace(12),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 18,
                          width: 120,
                          child: ShimmerPlaceholder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        HorizontalSpace(8),
                        SizedBox(
                          height: 18,
                          width: 72,
                          child: ShimmerPlaceholder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 8,
                      children: List.generate(
                        3,
                        (_) => SizedBox(
                          height: 14,
                          width: 110,
                          child: ShimmerPlaceholder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    VerticalSpace(10),
                    Wrap(
                      spacing: 12,
                      children: List.generate(
                        3,
                        (_) => SizedBox(
                          height: 12,
                          width: 80,
                          child: ShimmerPlaceholder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              HorizontalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                    width: 70,
                    child: ShimmerPlaceholder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  VerticalSpace(8),
                  SizedBox(
                    height: 12,
                    width: 56,
                    child: ShimmerPlaceholder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  VerticalSpace(12),
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: ShimmerPlaceholder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderEntity order;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final statusLabel = order.status.isEmpty ? 'Submitted' : order.status;
    final created = _formatDate(order.createdAt);
    final shipDate = _formatDate(order.requestedShipDate);
    final poNumber = (order.poNumber ?? '').trim();
    final itemsLabel = _pluralize(order.itemsCount, 'item', 'items');
    final transfersLabel = _pluralize(
      order.transfersCount,
      'transfer',
      'transfers',
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(order.jobNumber, style: TextStyles.text16700),
                    HorizontalSpace(8),
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
                VerticalSpace(10),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _MetaChip(
                      icon: Icons.business_outlined,
                      label: order.jobOwner.isEmpty ? '-' : order.jobOwner,
                    ),
                    _MetaChip(
                      icon: Icons.receipt_long_outlined,
                      label: poNumber.isEmpty ? 'PO: -' : 'PO: $poNumber',
                    ),
                    _MetaChip(
                      icon: Icons.calendar_today_outlined,
                      label: shipDate.isEmpty ? '-' : shipDate,
                    ),
                  ],
                ),
                VerticalSpace(8),
                Wrap(
                  spacing: 12,
                  children: [
                    Text(
                      itemsLabel,
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.secondaryText,
                      ),
                    ),
                    Text(
                      transfersLabel,
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.secondaryText,
                      ),
                    ),
                    Text(
                      created.isEmpty ? '' : 'Created $created',
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.secondaryText,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          HorizontalSpace(12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatCurrency(order.totalAmount),
                style: TextStyles.text18700.copyWith(
                  color: colorScheme.primary,
                ),
              ),
              VerticalSpace(4),
              Text(
                itemsLabel,
                style: TextStyles.text14400.copyWith(
                  color: colorScheme.secondaryText,
                ),
              ),
              VerticalSpace(8),
              const Icon(Icons.chevron_right),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});

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
  final formatted = value.toStringAsFixed(2);
  return '\$$formatted';
}

String _pluralize(int value, String singular, String plural) {
  if (value == 1) return '1 $singular';
  return '$value $plural';
}
