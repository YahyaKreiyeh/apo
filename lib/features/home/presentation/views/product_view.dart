//TODO: refactor to use select instead of bloc builder
import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/core/themes/app_colors.dart';
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
import 'package:url_launcher/url_launcher.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  static final Uri _decorateUrl = Uri.parse(
    'https://wordpress2.skyfy.me/source/productViwer3/',
  );

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
                    child: OutlinedButton(
                      onPressed: () async {
                        final launched = await launchUrl(
                          _decorateUrl,
                          mode: LaunchMode.externalApplication,
                        );
                        if (!launched) {
                          AppToast.show(
                            message: AppStrings.unknownError,
                            type: AppToastType.error,
                          );
                        }
                      },
                      child: const Text('Decorate'),
                    ),
                  ),
                  VerticalSpace(10),
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

class _ProductContent extends StatefulWidget {
  final ProductDetailsEntity product;
  final int quantity;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
  final int? selectedVariantId;
  final ValueChanged<int?> onVariantChanged;

  const _ProductContent({
    required this.product,
    required this.quantity,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.selectedVariantId,
    required this.onVariantChanged,
  });

  @override
  State<_ProductContent> createState() => _ProductContentState();
}

class _ProductContentState extends State<_ProductContent> {
  String? _selectedImageUrl;

  @override
  void initState() {
    super.initState();
    _selectedImageUrl = _initialImageUrl();
  }

  @override
  void didUpdateWidget(covariant _ProductContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.product.productId != widget.product.productId) {
      _selectedImageUrl = _initialImageUrl();
    }
  }

  String _initialImageUrl() {
    final selectedVariant = _findSelectedVariant(
      widget.product,
      widget.selectedVariantId,
    );
    final variantImageUrl = selectedVariant?.images.isNotEmpty == true
        ? selectedVariant!.images.first.imageUrl
        : null;
    if (widget.product.images.isNotEmpty) {
      return widget.product.images.first.imageUrl;
    }
    return variantImageUrl ?? Constants.getPlaceHolderImage(10);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = DeviceUtility.getScreenWidth(context);
    final isWideLayout = screenWidth >= 900;
    final selectedVariant = _findSelectedVariant(
      widget.product,
      widget.selectedVariantId,
    );
    final selectedVariantImageUrl = selectedVariant?.images.isNotEmpty == true
        ? selectedVariant!.images.first.imageUrl
        : null;
    final imageUrl =
        _selectedImageUrl ??
        selectedVariantImageUrl ??
        (widget.product.images.isNotEmpty
            ? widget.product.images.first.imageUrl
            : Constants.getPlaceHolderImage(10));
    final categoryNames = widget.product.categories
        .map((category) => category.categoryName ?? '')
        .where((name) => name.isNotEmpty)
        .toList();
    final variantPriceOverride = widget.product.basePrice > 0
        ? widget.product.basePrice
        : null;
    final fallbackImageUrl = widget.product.images.isNotEmpty
        ? widget.product.images.first.imageUrl
        : Constants.getPlaceHolderImage(10);
    final colorOptions = _variantColorOptions(
      widget.product.variants,
      fallbackImageUrl: fallbackImageUrl,
    );
    final selectedColorKey = selectedVariant == null
        ? null
        : _colorKey(selectedVariant.colorName, selectedVariant.colorCode);
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
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  _InfoChip(label: 'Top Seller'),
                  _InfoChip(label: 'New Color'),
                ],
              ),
            ],
          ),
        ),
        VerticalSpace(16),
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.product.productSKU, style: TextStyles.text14400),
            ],
          ),
        ),
        VerticalSpace(16),
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.product.productName, style: TextStyles.text24500),
            ],
          ),
        ),
        if (colorOptions.isNotEmpty) ...[
          VerticalSpace(16),
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(title: 'Color'),
                VerticalSpace(8),
                _ColorSwatchSelector(
                  options: colorOptions,
                  selectedColorKey: selectedColorKey,
                  onChanged: (variantId) {
                    final variant = _findSelectedVariant(
                      widget.product,
                      variantId,
                    );
                    final variantImageUrl = variant?.images.isNotEmpty == true
                        ? variant!.images.first.imageUrl
                        : null;
                    if (variantImageUrl != null) {
                      setState(() => _selectedImageUrl = variantImageUrl);
                    }
                    widget.onVariantChanged(variantId);
                  },
                ),
              ],
            ),
          ),
        ],
        if (categoryNames.isNotEmpty) ...[
          VerticalSpace(16),
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            ),
          ),
        ],
        if (widget.product.pricingTiers.isNotEmpty) ...[
          VerticalSpace(16),
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(title: AppStrings.pricingInformation),
                VerticalSpace(8),
                _PricingTable(tiers: widget.product.pricingTiers),
              ],
            ),
          ),
        ],
        VerticalSpace(16),
        if (widget.product.variants.isNotEmpty)
          _SectionCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionHeader(title: AppStrings.variant),
                VerticalSpace(8),
                _VariantDropdown(
                  variants: widget.product.variants,
                  selectedVariantId: widget.selectedVariantId,
                  onChanged: (variantId) {
                    final variant = _findSelectedVariant(
                      widget.product,
                      variantId,
                    );
                    final variantImageUrl = variant?.images.isNotEmpty == true
                        ? variant!.images.first.imageUrl
                        : null;
                    if (variantImageUrl != null) {
                      setState(() => _selectedImageUrl = variantImageUrl);
                    }
                    widget.onVariantChanged(variantId);
                  },
                  priceOverride: variantPriceOverride,
                ),
              ],
            ),
          ),
        VerticalSpace(16),
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(title: AppStrings.quantity),
              VerticalSpace(8),
              _QuantityPicker(
                quantity: widget.quantity,
                onDecrease: widget.onDecreaseQuantity,
                onIncrease: widget.onIncreaseQuantity,
              ),
            ],
          ),
        ),
        VerticalSpace(16),
        _SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionHeader(title: AppStrings.descriptionTitle),
              VerticalSpace(8),
              Text(widget.product.description, style: TextStyles.text14400),
            ],
          ),
        ),
      ],
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
                      if (widget.product.images.isNotEmpty) ...[
                        VerticalSpace(12),
                        _SectionHeader(title: 'Product Images'),
                        VerticalSpace(8),
                        _ProductImageStrip(
                          images: widget.product.images,
                          selectedUrl: _selectedImageUrl,
                          onSelected: (url) {
                            setState(() => _selectedImageUrl = url);
                          },
                        ),
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
            if (widget.product.images.isNotEmpty) ...[
              VerticalSpace(12),
              _SectionHeader(title: 'Product Images'),
              VerticalSpace(8),
              _ProductImageStrip(
                images: widget.product.images,
                selectedUrl: _selectedImageUrl,
                onSelected: (url) {
                  setState(() => _selectedImageUrl = url);
                },
              ),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline),
          borderRadius: BorderRadius.circular(12),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: theme.colorScheme.outline),
                  ),
                  columnWidths: {
                    0: const FixedColumnWidth(140),
                    for (var i = 0; i < sortedTiers.length; i++)
                      i + 1: const FixedColumnWidth(110),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                      ),
                      children: [
                        _PricingCell(
                          label: AppStrings.quantity,
                          isHeader: true,
                          alignStart: true,
                        ),
                        ...sortedTiers.map(
                          (tier) => _PricingCell(
                            label: _formatTierLabel(tier),
                            isHeader: true,
                          ),
                        ),
                      ],
                    ),
                    ...customizationKeys.map(
                      (key) => TableRow(
                        children: [
                          _PricingCell(
                            label: _formatCustomizationKey(key),
                            alignStart: true,
                            isRowHeader: true,
                          ),
                          ...sortedTiers.map(
                            (tier) => _PricingCell(
                              label: _formatPriceCell(
                                tier.customizationPrices[key],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PricingCell extends StatelessWidget {
  final String label;
  final bool isHeader;
  final bool alignStart;
  final bool isRowHeader;

  const _PricingCell({
    required this.label,
    this.isHeader = false,
    this.alignStart = false,
    this.isRowHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final alignment = alignStart ? Alignment.centerLeft : Alignment.center;
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(
        label,
        textAlign: alignStart ? TextAlign.left : TextAlign.center,
        style: isHeader || isRowHeader
            ? TextStyles.text14500
            : TextStyles.text14400,
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

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
        ),
      ),
      child: child,
    );
  }
}

class _ProductImageStrip extends StatelessWidget {
  final List<ProductImageEntity> images;
  final String? selectedUrl;
  final ValueChanged<String> onSelected;

  const _ProductImageStrip({
    required this.images,
    required this.selectedUrl,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, _) => HorizontalSpace(10),
        itemBuilder: (context, index) {
          final image = images[index];
          final isSelected = selectedUrl == image.imageUrl;
          final borderColor = isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline.withValues(alpha: 0.6);
          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onSelected(image.imageUrl),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: borderColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: image.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => ShimmerPlaceholder(),
                    errorWidget: (_, _, _) => NetworkImagePlaceholder(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ColorSwatchSelector extends StatelessWidget {
  final List<_ColorOption> options;
  final String? selectedColorKey;
  final ValueChanged<int?> onChanged;

  const _ColorSwatchSelector({
    required this.options,
    required this.selectedColorKey,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options
          .map(
            (option) => _ColorSwatch(
              option: option,
              isSelected: selectedColorKey == option.key,
              onTap: () => onChanged(option.variantId),
            ),
          )
          .toList(),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final _ColorOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorSwatch({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.outline.withValues(alpha: 0.6);
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: SizedBox(
        width: 92,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: borderColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: option.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => ShimmerPlaceholder(),
                    errorWidget: (_, _, _) => Container(color: option.color),
                  ),
                ),
              ),
            ),
            VerticalSpace(6),
            Text(
              option.name,
              style: TextStyles.text14400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
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

String _formatTierLabel(PricingTierEntity tier) {
  final range = _formatQuantityRange(tier.minQuantity, tier.maxQuantity);
  final code = tier.tierCode.trim();
  if (code.isEmpty) return range;
  return '$range\n($code)';
}

String _formatQuantityRange(int min, int? max) {
  if (max == null) return '$min+';
  if (min == max) return '$min';
  return '$min-$max';
}

String _formatPriceCell(double? price) {
  if (price == null) return '-';
  return '\$${price.toStringAsFixed(2)}';
}

List<_ColorOption> _variantColorOptions(
  List<VariantEntity> variants, {
  required String fallbackImageUrl,
}) {
  final options = <_ColorOption>[];
  final seen = <String>{};
  for (final variant in variants) {
    final key = _colorKey(variant.colorName, variant.colorCode);
    if (seen.contains(key)) continue;
    seen.add(key);
    final imageUrl = variant.images.isNotEmpty
        ? variant.images.first.imageUrl
        : fallbackImageUrl;
    options.add(
      _ColorOption(
        name: variant.colorName,
        color: _parseColorFromHex(variant.colorCode),
        imageUrl: imageUrl,
        variantId: variant.variantId,
        key: key,
      ),
    );
  }
  return options;
}

Color _parseColorFromHex(String hex) {
  final cleaned = hex.replaceAll('#', '').trim();
  if (cleaned.length == 6 || cleaned.length == 8) {
    final value = cleaned.length == 6 ? 'FF$cleaned' : cleaned.toUpperCase();
    final color = int.tryParse(value, radix: 16);
    if (color != null) {
      return Color(color);
    }
  }
  return AppColors.primary;
}

String _colorKey(String name, String code) {
  return '${name.trim().toLowerCase()}-${code.trim().toLowerCase()}';
}

class _ColorOption {
  final String name;
  final Color color;
  final String imageUrl;
  final int variantId;
  final String key;

  const _ColorOption({
    required this.name,
    required this.color,
    required this.imageUrl,
    required this.variantId,
    required this.key,
  });
}
