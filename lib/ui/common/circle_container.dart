import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({
    super.key,
    required this.child,
    this.color = Colors.white,
    this.width = 100,
    this.height = 100,
    this.borderWidth = 5,
  });

  final Widget child;
  final Color color;
  final double width;
  final double height;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.green, width: borderWidth),
      ),
      child: child,
    );
  }
}
