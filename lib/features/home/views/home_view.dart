import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/constants/theme_constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/utilities/device_utility.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/home/widgets/filter_chips.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: Constants.defaultPadding,
              vertical: 10,
            ),
            sliver: SliverAlignedGrid.count(
              itemBuilder: (context, index) {
                final imageUrl = Constants.getPlaceHolderImage(
                  (index + 1) * 10,
                );
                return Column(
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
                          child: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.favorite_outline),
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(14),
                    Text('Name'),
                  ],
                );
              },
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ),
          ),
        ],
      ),
    );
  }
}
