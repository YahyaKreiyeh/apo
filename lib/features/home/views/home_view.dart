//TODO: refactor to use select instead of bloc builder
import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/utilities/device_utility.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/home/presentation/cubits/products_cubit.dart';
import 'package:apo/features/home/presentation/cubits/products_state.dart';
import 'package:apo/features/home/widgets/filter_chips.dart';
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
        actions: [
          IconButton.filled(
            onPressed: () {},
            icon: Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
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
                  Text(AppStrings.hello, style: TextStyles.text28600),
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
                  ),
                  items: [10, 20, 30].map((ad) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Constants.defaultPadding,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          Constants.adsBannerRadius,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: Constants.getPlaceHolderImage(ad),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          placeholder: (_, _) => ShimmerPlaceholder(),
                          errorWidget: (_, _, _) => NetworkImagePlaceholder(),
                        ),
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
                    final imageUrl =
                        product.mainImage?.imageUrl ??
                        Constants.getPlaceHolderImage((index + 1) * 10);
                    return _ProductCard(
                      imageUrl: imageUrl,
                      name: product.productName,
                      price: product.priceRange?.min,
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
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double? price;
  final VoidCallback? onTap;

  const _ProductCard({
    required this.imageUrl,
    required this.name,
    required this.price,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                height:
                    (DeviceUtility.getScreenWidth(context) / 2) -
                    Constants.defaultPadding -
                    12,
                fit: BoxFit.cover,
                placeholder: (_, _) => ShimmerPlaceholder(),
                errorWidget: (_, _, _) => NetworkImagePlaceholder(),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton.filled(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_outline),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.secondaryContainer.withValues(
                      alpha: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
          VerticalSpace(14),
          Text(name, maxLines: 2, overflow: TextOverflow.ellipsis),
          if (price != null)
            Text(
              '\$${price!.toStringAsFixed(0)}',
              style: TextStyles.text14400.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductCardPlaceholder extends StatelessWidget {
  const _ProductCardPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height:
              (DeviceUtility.getScreenWidth(context) / 2) -
              Constants.defaultPadding -
              12,
          width: double.infinity,
          child: ShimmerPlaceholder(),
        ),
        VerticalSpace(14),
        Container(
          height: 14,
          width: 100,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        VerticalSpace(6),
        Container(
          height: 12,
          width: 60,
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
      ],
    );
  }
}
