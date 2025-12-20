import 'package:apo/core/style/assets/assets.gen.dart';
import 'package:flutter/material.dart';

class NetworkImagePlaceholder extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxFit fit;
  final Color? backgroundColor;

  const NetworkImagePlaceholder({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.fit = BoxFit.fill,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        height: height,
        width: width,
        color:
            backgroundColor ?? Theme.of(context).colorScheme.secondaryContainer,
        child: Assets.images.logo.image(fit: fit, height: height, width: width),
      ),
    );
  }
}
