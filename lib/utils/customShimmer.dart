import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    this.height,
    this.width,
    this.radius,
  });

  final double? height;
  final double? width;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      direction: ShimmerDirection.ltr,
      highlightColor: Colors.grey.shade400,
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
