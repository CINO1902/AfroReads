import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.height, required this.width});
  final double height, width;

  const ShimmerWidget.rectangle({
    required this.width,
    required this.height,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AfroReadsColors.grey.withOpacity(.7),
      highlightColor: Colors.white,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: AfroReadsColors.grey,
            borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
