//TODO: refactor to use select instead of bloc builder
import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/utilities/device_utility.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/presentation/cubits/product_details_cubit.dart';
import 'package:apo/features/home/presentation/cubits/product_details_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.product)),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(Constants.defaultPadding),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            child: Text(AppStrings.addToCart),
          ),
        ),
      ),
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const _ProductLoading();
          }
          if (state.status.isFailure) {
            return _ProductError(
              message: state.status.failureMessage,
              onRetry: () => context.read<ProductDetailsCubit>().load(),
            );
          }
          final product = state.status.successValue;
          if (product == null) {
            return _ProductError(
              message: AppStrings.unknownError,
              onRetry: () => context.read<ProductDetailsCubit>().load(),
            );
          }
          return _ProductContent(product: product);
        },
      ),
    );
  }
}

class _ProductLoading extends StatelessWidget {
  const _ProductLoading();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: DeviceUtility.getScreenWidth(context) * 0.8,
            width: double.infinity,
            child: ShimmerPlaceholder(),
          ),
          VerticalSpace(16),
          Container(
            height: 18,
            width: 160,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          VerticalSpace(8),
          Container(
            height: 14,
            width: 220,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          VerticalSpace(16),
          Container(
            height: 14,
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          VerticalSpace(6),
          Container(
            height: 14,
            width: double.infinity,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ],
      ),
    );
  }
}

class _ProductError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ProductError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: TextStyles.text14400),
            VerticalSpace(12),
            ElevatedButton(onPressed: onRetry, child: Text(AppStrings.retry)),
          ],
        ),
      ),
    );
  }
}

class _ProductContent extends StatelessWidget {
  final ProductDetailsEntity product;

  const _ProductContent({required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : Constants.getPlaceHolderImage(10);
    final price = _findBasePrice(product.variants);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: DeviceUtility.getScreenWidth(context) * 0.8,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, _) => ShimmerPlaceholder(),
              errorWidget: (_, _, _) => NetworkImagePlaceholder(),
            ),
          ),
          VerticalSpace(16),
          Text(product.productName, style: TextStyles.text17500),
          if (price != null)
            Text(
              '\$${price.toStringAsFixed(0)}',
              style: TextStyles.text14400.copyWith(
                color: Theme.of(context).colorScheme.secondaryText,
              ),
            ),
          VerticalSpace(12),
          Text(product.description, style: TextStyles.text14400),
          VerticalSpace(16),
          _InfoRow(label: 'SKU', value: product.productSKU),
          _InfoRow(
            label: 'MOQ',
            value: product.minimumOrderQuantity.toString(),
          ),
          _InfoRow(
            label: 'Production Days',
            value: product.standardProductionDays.toString(),
          ),
          if (product.manufacturingLocation.isNotEmpty)
            _InfoRow(label: 'Location', value: product.manufacturingLocation),
          VerticalSpace(80),
        ],
      ),
    );
  }

  double? _findBasePrice(List<VariantEntity> variants) {
    if (variants.isEmpty) return null;
    final prices = variants.map((variant) => variant.basePrice).toList();
    if (prices.isEmpty) return null;
    prices.sort();
    return prices.first;
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text('$label: ', style: TextStyles.text14400),
          Expanded(
            child: Text(
              value,
              style: TextStyles.text14400.copyWith(
                color: Theme.of(context).colorScheme.secondaryText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
