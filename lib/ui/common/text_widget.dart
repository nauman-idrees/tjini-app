import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.title,
    this.weight,
    this.size,
    this.color,
    this.maxLines,
    this.align = TextAlign.left,
    this.overflow,
    this.onPressed,
    this.decoration,
  });
  final String title;
  final FontWeight? weight;
  final double? size;
  final Color? color;
  final int? maxLines;
  final TextAlign align;
  final TextOverflow? overflow;
  final VoidCallback? onPressed;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return onPressed == null
        ? _getText()
        : TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: _getText(),
          );
  }

  Text _getText() {
    return Text(
      title,
      textAlign: align,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: size,
        color: color ?? AppColors.textColor,
        fontWeight: weight,
        overflow: overflow,
        decoration: decoration,
      ),
    );
  }
}
