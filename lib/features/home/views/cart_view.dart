import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.cart)),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Text(
                AppStrings.cartEmpty,
                style: TextStyles.text14400,
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            itemCount: state.items.length,
            separatorBuilder: (_, __) => VerticalSpace(12),
            itemBuilder: (context, index) {
              final item = state.items[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: item.imageUrl.isEmpty
                          ? const NetworkImagePlaceholder()
                          : CachedNetworkImage(
                              imageUrl: item.imageUrl,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorWidget: (_, __, ___) =>
                                  NetworkImagePlaceholder(),
                            ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: TextStyles.text14400,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          VerticalSpace(4),
                          Text(
                            item.unitPrice == null
                                ? '-'
                                : '\$${item.unitPrice!.toStringAsFixed(0)}',
                            style: TextStyles.text14400.copyWith(
                              color:
                                  Theme.of(context).colorScheme.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalSpace(4),
                    Text(
                      'x${item.quantity}',
                      style: TextStyles.text14400,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
