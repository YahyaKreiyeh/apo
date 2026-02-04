//TODO: refactor to use select instead of bloc builder
import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/core/style/assets/assets.gen.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/home/presentation/cubits/products_cubit.dart';
import 'package:apo/features/home/presentation/cubits/products_state.dart';
import 'package:apo/features/home/presentation/widgets/filter_chips.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<ProductsCubit>().loadInitial();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<ProductsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.filled(
          onPressed: () {},
          icon: Icon(Icons.menu_outlined),
        ),
        actionsPadding: EdgeInsets.only(right: 8),
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ProductsCubit>().loadInitial(),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.welcomeToApploEmb,
                      style: TextStyles.text15400.copyWith(
                        color: Theme.of(context).colorScheme.secondaryText,
                      ),
                    ),
                    VerticalSpace(17),
                    TextField(
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      textInputAction: TextInputAction.search,
                      style: TextStyles.text14400.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            ThemeConstants.inputFieldRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            ThemeConstants.inputFieldRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            ThemeConstants.inputFieldRadius,
                          ),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyles.text14400.copyWith(
                          color: Theme.of(context).colorScheme.hintText,
                        ),
                        prefixIcon: const Icon(Icons.search_outlined),
                        prefixIconColor: Theme.of(
                          context,
                        ).colorScheme.secondaryText,
                        hintText: AppStrings.search,
                      ),
                      onChanged: (v) {},
                      onSubmitted: (v) {},
                    ),
                    VerticalSpace(20),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      viewportFraction: 1,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                    ),
                    items:
                        [
                          Assets.images.banner1,
                          Assets.images.banner2,
                          Assets.images.banner3,
                          Assets.images.banner4,
                          Assets.images.banner5,
                          Assets.images.banner6,
                          Assets.images.banner7,
                          Assets.images.banner8,
                          Assets.images.banner9,
                        ].map((banner) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.defaultPadding,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Constants.adsBannerRadius,
                              ),
                              child: banner.image(fit: BoxFit.fill),
                              // CachedNetworkImage(
                              //   imageUrl: Constants.getPlaceHolderImage(ad),
                              //   fit: BoxFit.fill,
                              //   width: double.infinity,
                              //   placeholder: (_, _) => ShimmerPlaceholder(),
                              //   errorWidget: (_, _, _) => NetworkImagePlaceholder(),
                              // ),
                            ),
                          );
                        }).toList(),
                  ),
                  VerticalSpace(10),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: FilterChips(
                filters: [
                  AppStrings.newStylesAndColors,
                  AppStrings.topSellers,
                  AppStrings.knits,
                ],
                selectedIndex: 0,
                onSelected: (s) {},
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.defaultPadding,
                ),
                child: Text(AppStrings.topSellers, style: TextStyles.text17500),
              ),
            ),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                final showInitialLoading =
                    state.status.isLoading && state.items.isEmpty;
                final showError = state.status.isFailure && state.items.isEmpty;
                if (showError) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Text(
                            state.status.failureMessage,
                            style: TextStyles.text14400,
                          ),
                          VerticalSpace(12),
                          ElevatedButton(
                            onPressed: () =>
                                context.read<ProductsCubit>().loadInitial(),
                            child: Text(AppStrings.retry),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                final itemsCount = showInitialLoading ? 6 : state.items.length;
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding,
                    vertical: 10,
                  ),
                  sliver: SliverAlignedGrid.count(
                    itemCount: itemsCount,
                    itemBuilder: (context, index) {
                      if (showInitialLoading) {
                        return _ProductCardPlaceholder();
                      }
                      final product = state.items[index];
                      final imageUrl = product.images.first.imageUrl;
                      final displayPrice =
                          product.priceRange?.min ??
                          (product.basePrice > 0 ? product.basePrice : null);
                      return _ProductCard(
                        imageUrl: imageUrl,
                        name: product.productName,
                        sku: product.productSKU,
                        description: product.description,
                        price: displayPrice,
                        onTap: () => context.pushNamed(
                          RouteNames.product.name,
                          pathParameters: {'id': product.productId.toString()},
                        ),
                      );
                    },
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                );
              },
            ),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (!state.isLoadingMore) return const SliverToBoxAdapter();
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String sku;
  final String description;
  final double? price;
  final VoidCallback? onTap;

  const _ProductCard({
    required this.imageUrl,
    required this.name,
    required this.sku,
    required this.description,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardRadius = BorderRadius.circular(14);
    final secondaryText = theme.colorScheme.secondaryText;
    return InkWell(
      onTap: onTap,
      borderRadius: cardRadius,
      child: Ink(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: cardRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, _) => ShimmerPlaceholder(),
                        errorWidget: (_, _, _) => NetworkImagePlaceholder(),
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton.filled(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.secondaryContainer
                              .withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VerticalSpace(12),
                  Text(
                    name,
                    style: TextStyles.text14500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VerticalSpace(6),
                  Text(
                    sku,
                    style: TextStyles.text14400.copyWith(
                      fontSize: 12,
                      color: secondaryText,
                    ),
                  ),
                  if (price != null) ...[
                    VerticalSpace(10),
                    Text(
                      AppStrings.asLowAs,
                      style: TextStyles.text14400.copyWith(
                        fontSize: 12,
                        color: secondaryText,
                      ),
                    ),
                    Text(
                      '\$${price!.toStringAsFixed(2)}',
                      style: TextStyles.text18700.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                  if (description.isNotEmpty) ...[
                    VerticalSpace(8),
                    Text(
                      description,
                      style: TextStyles.text14400.copyWith(
                        color: secondaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCardPlaceholder extends StatelessWidget {
  const _ProductCardPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardRadius = BorderRadius.circular(14);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: cardRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 18,
                offset: Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: ShimmerPlaceholder(),
                ),
              ),
              VerticalSpace(12),
              Container(
                height: 14,
                width: 110,
                color: theme.colorScheme.secondaryContainer,
              ),
              VerticalSpace(6),
              Container(
                height: 12,
                width: 70,
                color: theme.colorScheme.secondaryContainer,
              ),
              VerticalSpace(12),
              Container(
                height: 12,
                width: 60,
                color: theme.colorScheme.secondaryContainer,
              ),
              VerticalSpace(6),
              Container(
                height: 16,
                width: 80,
                color: theme.colorScheme.secondaryContainer,
              ),
              VerticalSpace(8),
              Container(
                height: 12,
                width: 90,
                color: theme.colorScheme.secondaryContainer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
