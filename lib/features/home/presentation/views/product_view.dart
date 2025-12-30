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
    final theme = Theme.of(context);
    final screenWidth = DeviceUtility.getScreenWidth(context);
    final isWideLayout = screenWidth >= 900;
    final imageUrl = product.images.isNotEmpty
        ? product.images.first.imageUrl
        : Constants.getPlaceHolderImage(10);
    final inStock = product.isStockItem;
    final categoryNames = product.categories
        .map((category) => category.categoryName ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    final priceRange = _findPricingRange(product);
    final variantPriceOverride = product.basePrice > 0
        ? product.basePrice
        : null;
    final imageCard = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1.1,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, _) => ShimmerPlaceholder(),
            errorWidget: (_, _, _) => NetworkImagePlaceholder(),
          ),
        ),
      ),
    );
    final detailsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.productName, style: TextStyles.text24500),
        VerticalSpace(4),
        Text(
          product.productSKU,
          style: TextStyles.text14400.copyWith(
            color: theme.colorScheme.secondaryText,
          ),
        ),
        if (priceRange != null) ...[
          VerticalSpace(8),
          Text(
            priceRange.min == priceRange.max
                ? '\$${priceRange.min.toStringAsFixed(2)}'
                : '\$${priceRange.min.toStringAsFixed(2)} - \$${priceRange.max.toStringAsFixed(2)}',
            style: TextStyles.text24500.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
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
        VerticalSpace(16),
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
        if (product.pricingTiers.isNotEmpty) ...[
          VerticalSpace(16),
          _SectionHeader(title: AppStrings.pricingInformation),
          VerticalSpace(8),
          _PricingTable(tiers: product.pricingTiers),
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
            priceOverride: variantPriceOverride,
          ),
          VerticalSpace(12),
        ],
        Text(AppStrings.customizationType),
        VerticalSpace(12),
        const _CustomizationDropdown(),
        VerticalSpace(12),
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
      ],
    );
    final variantsSection = _VariantsSection(
      variants: product.variants,
      isWideLayout: isWideLayout,
      priceOverride: variantPriceOverride,
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWideLayout)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      imageCard,
                      if (product.variants.isNotEmpty) ...[
                        VerticalSpace(16),
                        variantsSection,
                      ],
                    ],
                  ),
                ),
                HorizontalSpace(24),
                Expanded(flex: 4, child: detailsColumn),
              ],
            )
          else ...[
            imageCard,
            if (product.variants.isNotEmpty) ...[
              VerticalSpace(16),
              variantsSection,
            ],
            VerticalSpace(16),
            detailsColumn,
          ],
          VerticalSpace(80),
        ],
      ),
    );
  }
}

class _VariantsSection extends StatelessWidget {
  final List<VariantEntity> variants;
  final bool isWideLayout;
  final double? priceOverride;

  const _VariantsSection({
    required this.variants,
    required this.isWideLayout,
    required this.priceOverride,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: AppStrings.availableVariants),
        VerticalSpace(8),
        LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = isWideLayout ? 220.0 : constraints.maxWidth;
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: variants
                  .map(
                    (variant) => SizedBox(
                      width: cardWidth,
                      child: _VariantCard(
                        variant: variant,
                        priceOverride: priceOverride,
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
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
  final double? priceOverride;

  const _VariantCard({required this.variant, required this.priceOverride});

  @override
  Widget build(BuildContext context) {
    final sizeLabel = variant.sizeType?.sizeName ?? variant.sizeType?.sizeCode;
    final stockLabel = 'Stock: ${variant.inventoryAvailable}';
    final price = priceOverride ?? variant.basePrice;
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
                '\$${price.toStringAsFixed(2)}',
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

class _PricingTable extends StatelessWidget {
  final List<PricingTierEntity> tiers;

  const _PricingTable({required this.tiers});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sortedTiers = [...tiers]
      ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    final customizationKeys = _pricingCustomizationKeys(sortedTiers);
    if (customizationKeys.isEmpty) return const SizedBox.shrink();
    final key = customizationKeys.first;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder.symmetric(
            inside: BorderSide(color: theme.colorScheme.outline),
          ),
          columnWidths: const {0: FlexColumnWidth(1.2), 1: FlexColumnWidth(1)},
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
              ),
              children: [
                _PricingCell(
                  label: AppStrings.customizationType,
                  isHeader: true,
                  alignStart: true,
                ),
                _PricingCell(
                  label: _formatCustomizationKey(key),
                  isHeader: true,
                ),
              ],
            ),
            ...sortedTiers.map((tier) {
              final price = tier.customizationPrices[key];
              return TableRow(
                children: [
                  _PricingCell(label: tier.tierName, alignStart: true),
                  _PricingCell(
                    label: price == null
                        ? '-'
                        : '\$${price.toStringAsFixed(2)}',
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PricingCell extends StatelessWidget {
  final String label;
  final bool isHeader;
  final bool alignStart;

  const _PricingCell({
    required this.label,
    this.isHeader = false,
    this.alignStart = false,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = alignStart ? Alignment.centerLeft : Alignment.center;
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        label,
        style: isHeader ? TextStyles.text14500 : TextStyles.text14400,
      ),
    );
  }
}

class _VariantDropdown extends StatelessWidget {
  final List<VariantEntity> variants;
  final int? selectedVariantId;
  final ValueChanged<int?> onChanged;
  final double? priceOverride;

  const _VariantDropdown({
    required this.variants,
    required this.selectedVariantId,
    required this.onChanged,
    required this.priceOverride,
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
                _variantLabel(variant, priceOverride: priceOverride),
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

class _CustomizationDropdown extends StatelessWidget {
  const _CustomizationDropdown();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: AppStrings.blank,
      isExpanded: true,
      decoration: InputDecoration(
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
      items: const [
        DropdownMenuItem(
          value: AppStrings.blank,
          child: Text(AppStrings.blank),
        ),
        DropdownMenuItem(
          value: AppStrings.selectCustomization,
          child: Text(AppStrings.selectCustomization),
        ),
      ],
      onChanged: (_) {},
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

_PriceRange? _findPricingRange(ProductDetailsEntity product) {
  final tiers = product.pricingTiers;
  if (tiers.isNotEmpty) {
    final prices = tiers
        .map((tier) => tier.customizationPrices['BLANK'])
        .whereType<double>()
        .toList();
    if (prices.isNotEmpty) {
      prices.sort();
      return _PriceRange(prices.first, prices.last);
    }
  }
  if (product.basePrice > 0) {
    return _PriceRange(product.basePrice, product.basePrice);
  }
  final variantPrices = product.variants
      .map((variant) => variant.basePrice)
      .where((price) => price > 0)
      .toList();
  if (variantPrices.isEmpty) return null;
  variantPrices.sort();
  return _PriceRange(variantPrices.first, variantPrices.last);
}

String _variantLabel(VariantEntity variant, {double? priceOverride}) {
  final sizeLabel = variant.sizeType?.sizeName ?? variant.sizeType?.sizeCode;
  final baseLabel = sizeLabel == null
      ? variant.colorName
      : '${variant.colorName} • $sizeLabel';
  final price = priceOverride ?? variant.basePrice;
  return '$baseLabel • \$${price.toStringAsFixed(2)}';
}

List<String> _pricingCustomizationKeys(List<PricingTierEntity> tiers) {
  final keys = <String>{};
  for (final tier in tiers) {
    keys.addAll(tier.customizationPrices.keys);
  }
  final list = keys.toList();
  list.sort((a, b) {
    if (a.toUpperCase() == 'BLANK') return -1;
    if (b.toUpperCase() == 'BLANK') return 1;
    return a.compareTo(b);
  });
  return list;
}

String _formatCustomizationKey(String key) {
  if (key.toUpperCase() == 'BLANK') return AppStrings.blank;
  return key[0].toUpperCase() + key.substring(1).toLowerCase();
}

class _PriceRange {
  final double min;
  final double max;

  const _PriceRange(this.min, this.max);
}
