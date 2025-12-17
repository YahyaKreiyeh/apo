import 'package:apo/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const double height = 90;
    const Duration dur = Duration(milliseconds: 220);
    const Curve curve = Curves.easeOut;
    const double indicatorHeight = 3;
    final Color active = theme.colorScheme.primary;
    final Color inactive = theme.colorScheme.secondary;
    final Color outline = theme.colorScheme.outline;
    final Color indicator = active;
    _Item home = _Item(icon: Icon(Icons.home_outlined), label: 'Home');
    _Item cart = _Item(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart');
    _Item orders = _Item(icon: Icon(Icons.list_outlined), label: 'Orders');
    _Item profile = _Item(icon: Icon(Icons.person_outline), label: 'Profile');
    List<_Item> items = [home, cart, orders, profile];
    final int currentIndex = navigationShell.currentIndex;

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        border: Border(top: BorderSide(color: outline, width: 1)),
      ),
      height: height,
      width: double.infinity,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final double slotWidth = constraints.maxWidth / items.length;
              final double indicatorWidth = slotWidth * 0.5;
              final double left =
                  (currentIndex * slotWidth) + (slotWidth - indicatorWidth) / 2;
              return SizedBox(
                height: indicatorHeight,
                width: constraints.maxWidth,
                child: Stack(
                  children: [
                    AnimatedPositionedDirectional(
                      duration: dur,
                      curve: curve,
                      start: left,
                      top: 0,
                      width: indicatorWidth,
                      height: indicatorHeight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: indicator,
                          borderRadius: const BorderRadiusDirectional.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          VerticalSpace(5),
          Row(
            children: List.generate(items.length, (i) {
              final _Item it = items[i];
              final bool selected = i == currentIndex;
              return Expanded(
                child: GestureDetector(
                  onTap: () =>
                      navigationShell.goBranch(i, initialLocation: true),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedScale(
                        duration: const Duration(milliseconds: 180),
                        scale: selected ? 1.1 : 1.0,
                        child: IconTheme(
                          data: IconThemeData(
                            color: selected ? active : inactive,
                          ),
                          child: it.icon,
                        ),
                      ),
                      VerticalSpace(6),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 180),
                        style: TextStyle(
                          fontSize: 11,
                          color: selected ? active : inactive,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                        child: Text(
                          it.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _Item {
  const _Item({required this.icon, required this.label});
  final Widget icon;
  final String label;
}
