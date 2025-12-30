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
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
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
        final isAuthenticated = context.select<ProfileCubit, bool>(
          (cubit) => cubit.state.isAuthenticated,
        );
        return BlocListener<CartCubit, CartState>(
          listenWhen: (previous, current) =>
              previous.addStatus != current.addStatus,
          listener: (context, cartState) {
            if (cartState.addStatus.isSuccess) {
              AppToast.show(
                message: AppStrings.addedToCart,
                type: AppToastType.success,
              );
            }
            if (cartState.addStatus.isFailure) {
              AppToast.show(
                message: cartState.addStatus.failureMessage,
                type: AppToastType.error,
              );
            }
          },
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actionsPadding: EdgeInsets.only(right: 8),
              actions: [
                IconButton.filled(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.secondaryContainer.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
                BlocBuilder<CartCubit, CartState>(
                  builder: (context, cartState) {
                    return IconButton.filled(
                      onPressed: () => context.goNamed(RouteNames.cart.name),
                      icon: _CartBadgeIcon(count: cartState.totalItems),
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.secondaryContainer
                            .withValues(alpha: 0.5),
                      ),
                    );
                  },
                ),
              ],
            ),
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.all(Constants.defaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, cartState) {
                        return ElevatedButton(
                          onPressed: product == null
                              ? null
                              : cartState.addStatus.isLoading
                              ? () {}
                              : () async {
                                  final selectedVariant = _findSelectedVariant(
                                    product,
                                    state.selectedVariantId,
                                  );
                                  final cartCubit = context.read<CartCubit>();
                                  if (isAuthenticated) {
                                    await cartCubit.addProduct(
                                      product,
                                      quantity: state.quantity,
                                      hasPersonalization:
                                          state.hasPersonalization,
                                      selectedVariant: selectedVariant,
                                    );
                                  } else {
                                    cartCubit.addProductLocally(
                                      product,
                                      quantity: state.quantity,
                                      hasPersonalization:
                                          state.hasPersonalization,
                                      selectedVariant: selectedVariant,
                                    );
                                  }
                                },
                          child: cartState.addStatus.isLoading
                              ? CircularProgressIndicator()
                              : Text(AppStrings.addToCart),
                        );
                      },
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
                return _ProductContent(
                  product: product,
                  quantity: state.quantity,
                  hasPersonalization: state.hasPersonalization,
                  onPersonalizationChanged: (value) => context
                      .read<ProductDetailsCubit>()
                      .setHasPersonalization(value),
                  onIncreaseQuantity: () =>
                      context.read<ProductDetailsCubit>().increaseQuantity(),
                  onDecreaseQuantity: () =>
                      context.read<ProductDetailsCubit>().decreaseQuantity(),
                  selectedVariantId: state.selectedVariantId,
                  onVariantChanged: (variantId) => context
                      .read<ProductDetailsCubit>()
                      .setSelectedVariant(variantId),
                );
              },
            ),
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
  final int quantity;
  final bool hasPersonalization;
  final ValueChanged<bool> onPersonalizationChanged;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
  final int? selectedVariantId;
  final ValueChanged<int?> onVariantChanged;

  const _ProductContent({
    required this.product,
    required this.quantity,
    required this.hasPersonalization,
    required this.onPersonalizationChanged,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.selectedVariantId,
    required this.onVariantChanged,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : Constants.getPlaceHolderImage(10);
    final selectedVariant = _findSelectedVariant(product, selectedVariantId);
    final price =
        selectedVariant?.basePrice ?? _findBasePrice(product.variants);
    final inStock = product.isStockItem;
    final categoryNames = product.categories
        .map((category) => category.categoryName ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            height: DeviceUtility.getScreenWidth(context) * 0.8,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (_, _) => ShimmerPlaceholder(),
            errorWidget: (_, _, _) => NetworkImagePlaceholder(),
          ),
          VerticalSpace(16),
          Text(product.productName, style: TextStyles.text17500),
          VerticalSpace(4),
          Text(
            product.productSKU,
            style: TextStyles.text14400.copyWith(
              color: Theme.of(context).colorScheme.secondaryText,
            ),
          ),
          if (price != null)
            Text(
              '\$${price.toStringAsFixed(0)}',
              style: TextStyles.text28600.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          VerticalSpace(12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoChip(
                label: inStock ? AppStrings.inStock : AppStrings.outOfStock,
              ),
              if (product.hasVariants || product.variants.length > 1)
                _InfoChip(label: AppStrings.multipleVariants),
              if (product.hasCustomization)
                _InfoChip(label: AppStrings.customization),
              if (product.isUSAMade) _InfoChip(label: AppStrings.usaMade),
              if (product.model3DUrl.isNotEmpty)
                _InfoChip(label: AppStrings.model3d),
            ],
          ),
          VerticalSpace(12),
          _SectionHeader(title: AppStrings.descriptionTitle),
          VerticalSpace(8),
          Text(product.description, style: TextStyles.text14400),
          if (categoryNames.isNotEmpty) ...[
            VerticalSpace(16),
            _SectionHeader(title: AppStrings.categories),
            VerticalSpace(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categoryNames
                  .map((name) => _TagChip(label: name))
                  .toList(),
            ),
          ],
          if (product.variants.isNotEmpty) ...[
            VerticalSpace(16),
            _SectionHeader(title: AppStrings.availableVariants),
            VerticalSpace(8),
            Column(
              children: product.variants
                  .map(
                    (variant) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _VariantCard(variant: variant),
                    ),
                  )
                  .toList(),
            ),
          ],
          VerticalSpace(16),
          _SectionHeader(title: AppStrings.productionInformation),
          VerticalSpace(8),
          LayoutBuilder(
            builder: (context, constraints) {
              final itemWidth = (constraints.maxWidth - 12) / 2;
              return Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  SizedBox(
                    width: itemWidth,
                    child: _InfoTile(
                      title: AppStrings.minimumOrder,
                      value: '${product.minimumOrderQuantity} units',
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _InfoTile(
                      title: AppStrings.standardProduction,
                      value: '${product.standardProductionDays} days',
                    ),
                  ),
                  SizedBox(
                    width: itemWidth,
                    child: _InfoTile(
                      title: AppStrings.rushProduction,
                      value: '${product.rushProductionDays} days',
                    ),
                  ),
                  if (product.manufacturingLocation.isNotEmpty)
                    SizedBox(
                      width: itemWidth,
                      child: _InfoTile(
                        title: AppStrings.location,
                        value: product.manufacturingLocation,
                      ),
                    ),
                ],
              );
            },
          ),
          VerticalSpace(16),
          if (product.variants.isNotEmpty) ...[
            Text(AppStrings.variant),
            VerticalSpace(12),
            _VariantDropdown(
              variants: product.variants,
              selectedVariantId: selectedVariantId,
              onChanged: onVariantChanged,
            ),
            VerticalSpace(12),
          ],
          _QuantityPicker(
            quantity: quantity,
            onDecrease: onDecreaseQuantity,
            onIncrease: onIncreaseQuantity,
          ),
          VerticalSpace(12),
          _PersonalizationToggle(
            value: hasPersonalization,
            onChanged: onPersonalizationChanged,
          ),
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

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyles.text17500);
  }
}

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyles.text14400),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String label;

  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: TextStyles.text14400),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.text14400.copyWith(
              color: Theme.of(context).colorScheme.secondaryText,
            ),
          ),
          VerticalSpace(6),
          Text(value, style: TextStyles.text14400),
        ],
      ),
    );
  }
}

class _VariantCard extends StatelessWidget {
  final VariantEntity variant;

  const _VariantCard({required this.variant});

  @override
  Widget build(BuildContext context) {
    final sizeLabel = variant.sizeType?.sizeName ?? variant.sizeType?.sizeCode;
    final stockLabel = 'Stock: ${variant.inventoryAvailable}';
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: _parseColor(context, variant.colorCode),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 0.5,
                  ),
                ),
              ),
              HorizontalSpace(8),
              Expanded(
                child: Text(
                  sizeLabel == null
                      ? variant.colorName
                      : '${variant.colorName} • $sizeLabel',
                  style: TextStyles.text14400,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '\$${variant.basePrice.toStringAsFixed(0)}',
                style: TextStyles.text14400.copyWith(
                  color: Theme.of(context).colorScheme.secondaryText,
                ),
              ),
            ],
          ),
          VerticalSpace(6),
          Text(
            stockLabel,
            style: TextStyles.text14400.copyWith(
              color: Theme.of(context).colorScheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }

  Color _parseColor(BuildContext context, String hex) {
    final cleaned = hex.replaceAll('#', '').trim();
    if (cleaned.length == 6 || cleaned.length == 8) {
      final value = cleaned.length == 6 ? 'FF$cleaned' : cleaned.toUpperCase();
      final color = int.tryParse(value, radix: 16);
      if (color != null) {
        return Color(color);
      }
    }
    return Theme.of(context).colorScheme.primary;
  }
}

class _VariantDropdown extends StatelessWidget {
  final List<VariantEntity> variants;
  final int? selectedVariantId;
  final ValueChanged<int?> onChanged;

  const _VariantDropdown({
    required this.variants,
    required this.selectedVariantId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedSelectedId =
        selectedVariantId ??
        (variants.isNotEmpty ? variants.first.variantId : null);
    return DropdownButtonFormField<int>(
      initialValue: resolvedSelectedId,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: AppStrings.selectVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      items: variants
          .map(
            (variant) => DropdownMenuItem<int>(
              value: variant.variantId,
              child: Text(
                _variantLabel(variant),
                style: TextStyles.text14400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
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
                child: Text(quantity.toString(), style: TextStyles.text14400),
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

class _PersonalizationToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _PersonalizationToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onChanged(!value),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.hasPersonalization, style: TextStyles.text14400),
              Checkbox(
                value: value,
                onChanged: (updated) => onChanged(updated ?? false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

VariantEntity? _findSelectedVariant(
  ProductDetailsEntity product,
  int? variantId,
) {
  if (product.variants.isEmpty) return null;
  if (variantId == null) return product.variants.first;
  return product.variants.firstWhere(
    (variant) => variant.variantId == variantId,
    orElse: () => product.variants.first,
  );
}

String _variantLabel(VariantEntity variant) {
  final sizeLabel = variant.sizeType?.sizeName ?? variant.sizeType?.sizeCode;
  final baseLabel = sizeLabel == null
      ? variant.colorName
      : '${variant.colorName} • $sizeLabel';
  return '$baseLabel • \$${variant.basePrice.toStringAsFixed(0)}';
}
