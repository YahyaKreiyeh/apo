import 'package:apo/core/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceholder extends StatelessWidget {
  final BorderRadius? borderRadius;

  const ShimmerPlaceholder({super.key, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final baseColor = scheme.shimmerBase;
    final highlightColor = scheme.shimmerHighlight;
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius, color: baseColor),
      ),
    );
  }
}
