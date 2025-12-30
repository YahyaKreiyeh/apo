import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select<ProfileCubit, bool>(
      (cubit) => cubit.state.isAuthenticated,
    );

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.cart)),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const SizedBox.shrink();
          }
          final primaryActionType = isAuthenticated
              ? CheckoutType.checkout
              : CheckoutType.requestQuote;
          final primaryActionLabel = isAuthenticated
              ? AppStrings.checkout
              : AppStrings.requestQuote;

          return SafeArea(
            minimum: const EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () => context.goNamed(RouteNames.home.name),
                  child: Text(AppStrings.continueShopping),
                ),
                if (isAuthenticated) ...[
                  VerticalSpace(12),
                  OutlinedButton(
                    onPressed: () => context.pushNamed(
                      RouteNames.checkout.name,
                      extra: CheckoutType.requestQuote,
                    ),
                    child: Text(AppStrings.requestQuote),
                  ),
                ],
                VerticalSpace(12),
                ElevatedButton(
                  onPressed: () => context.pushNamed(
                    RouteNames.checkout.name,
                    extra: primaryActionType,
                  ),
                  child: Text(primaryActionLabel),
                ),
              ],
            ),
          );
        },
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final showInitialLoading =
              state.cartStatus.isLoading && state.items.isEmpty;
          final showError = state.cartStatus.isFailure && state.items.isEmpty;
          if (showInitialLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (showError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.cartStatus.failureMessage,
                      style: TextStyles.text14400,
                    ),
                    VerticalSpace(12),
                    ElevatedButton(
                      onPressed: () => context.read<CartCubit>().loadCart(),
                      child: Text(AppStrings.retry),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state.items.isEmpty) {
            return Center(
              child: Text(AppStrings.cartEmpty, style: TextStyles.text14400),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            itemCount: state.items.length,
            separatorBuilder: (_, index) => VerticalSpace(12),
            itemBuilder: (context, index) {
              final item = state.items[index];
              return Dismissible(
                key: ValueKey('${item.productId}-${item.variantId}'),
                background: _DismissBackground(
                  alignment: Alignment.centerLeft,
                  icon: Icons.delete_outline,
                ),
                secondaryBackground: _DismissBackground(
                  alignment: Alignment.centerRight,
                  icon: Icons.delete_outline,
                ),
                onDismissed: (_) => context.read<CartCubit>().removeItem(
                  item.productId,
                  item.variantId,
                ),
                child: Container(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(
                      Constants.defaultRadius,
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outlineVariant,
                              ),
                            ),
                            child: item.imageUrl.isEmpty
                                ? const NetworkImagePlaceholder()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: item.imageUrl,
                                      fit: BoxFit.cover,
                                      errorWidget: (_, _, _) =>
                                          NetworkImagePlaceholder(),
                                    ),
                                  ),
                          ),
                          HorizontalSpace(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: TextStyles.text14400.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                VerticalSpace(6),
                                Text(
                                  '${AppStrings.sku}: ${item.productSku.isEmpty ? '-' : item.productSku}',
                                  style: TextStyles.text14400.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      VerticalSpace(12),
                      Row(
                        children: [
                          Text(
                            AppStrings.quantity,
                            style: TextStyles.text14400.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.secondaryText,
                            ),
                          ),
                          HorizontalSpace(12),
                          _QuantityStepper(
                            quantity: item.quantity,
                            onDecrease: item.quantity > 1
                                ? () =>
                                      context.read<CartCubit>().updateQuantity(
                                        item.productId,
                                        item.variantId,
                                        item.quantity - 1,
                                      )
                                : null,
                            onIncrease: () =>
                                context.read<CartCubit>().updateQuantity(
                                  item.productId,
                                  item.variantId,
                                  item.quantity + 1,
                                ),
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                AppStrings.unitPrice,
                                style: TextStyles.text14400.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondaryText,
                                ),
                              ),
                              VerticalSpace(4),
                              Text(
                                item.unitPrice == null
                                    ? '-'
                                    : '\$${item.unitPrice!.toStringAsFixed(0)}',
                                style: TextStyles.text14400.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      VerticalSpace(12),
                      Divider(
                        height: 1,
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      VerticalSpace(8),
                      CheckboxListTile(
                        value: item.hasPersonalization,
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          AppStrings.includeCustomEmbroideryPersonalization,
                          style: TextStyles.text14400,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) =>
                            context.read<CartCubit>().updatePersonalization(
                              item.productId,
                              item.variantId,
                              value ?? false,
                            ),
                      ),
                      VerticalSpace(8),
                      Text(
                        '${AppStrings.productionNotes} ${AppStrings.optional}',
                        style: TextStyles.text14400.copyWith(
                          color: Theme.of(context).colorScheme.secondaryText,
                        ),
                      ),
                      VerticalSpace(8),
                      TextField(
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        decoration: InputDecoration(
                          hintText: AppStrings
                              .logoPlacementThreadColorsSpecialInstructions,
                          hintMaxLines: 2,
                          filled: true,
                          fillColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Theme.of(
                                context,
                              ).colorScheme.outlineVariant,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({required this.alignment, required this.icon});

  final Alignment alignment;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.onErrorContainer),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback? onDecrease;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(icon: Icons.remove, onPressed: onDecrease),
          const SizedBox(width: 8),
          SizedBox(
            width: 28,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyles.text14400.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _StepButton(icon: Icons.add, onPressed: onIncrease),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null;
    final iconColor = isEnabled
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: 0.4);

    return SizedBox(
      width: 32,
      height: 32,
      child: Material(
        color: colorScheme.surface,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Icon(icon, size: 18, color: iconColor),
        ),
      ),
    );
  }
}
