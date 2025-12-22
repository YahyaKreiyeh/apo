//TODO: refactor to use select instead of bloc builder
import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/utilities/device_utility.dart';
import 'package:apo/core/widgets/app_toast.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/home/domain/models/product_details_entity.dart';
import 'package:apo/features/home/domain/models/product_entity.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:apo/features/home/presentation/cubits/product_details_cubit.dart';
import 'package:apo/features/home/presentation/cubits/product_details_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final product = state.status.successValue;
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.product),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, cartState) {
                    return IconButton.filled(
                      onPressed: () => context.goNamed(RouteNames.cart.name),
                      icon: _CartBadgeIcon(count: cartState.totalItems),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QuantityPicker(
                  quantity: state.quantity,
                  onDecrease: () =>
                      context.read<ProductDetailsCubit>().decreaseQuantity(),
                  onIncrease: () =>
                      context.read<ProductDetailsCubit>().increaseQuantity(),
                ),
                VerticalSpace(12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: product == null
                        ? null
                        : () {
                            context
                                .read<CartCubit>()
                                .addProduct(product, quantity: state.quantity);
                            AppToast.show(
                              message: AppStrings.addedToCart,
                              type: AppToastType.success,
                            );
                          },
                    child: Text(AppStrings.addToCart),
                  ),
                ),
              ],
            ),
          ),
          body: Builder(
            builder: (context) {
              if (state.status.isLoading) {
                return const _ProductLoading();
              }
              if (state.status.isFailure) {
                return _ProductError(
                  message: state.status.failureMessage,
                  onRetry: () => context.read<ProductDetailsCubit>().load(),
                );
              }
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
      },
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

class _CartBadgeIcon extends StatelessWidget {
  final int count;

  const _CartBadgeIcon({required this.count});

  @override
  Widget build(BuildContext context) {
    final icon = const Icon(Icons.shopping_bag_outlined);
    if (count <= 0) return icon;
    return Badge(
      backgroundColor: AppColors.red,
      label: Text(
        count > 99 ? '99+' : count.toString(),
        style: const TextStyle(
          color: AppColors.whiteText,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      child: icon,
    );
  }
}

class _QuantityPicker extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const _QuantityPicker({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(AppStrings.quantity, style: TextStyles.text14400),
          Row(
            children: [
              IconButton(
                onPressed: onDecrease,
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                child: Text(
                  quantity.toString(),
                  style: TextStyles.text14400,
                ),
              ),
              IconButton(
                onPressed: onIncrease,
                icon: const Icon(Icons.keyboard_arrow_up),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
