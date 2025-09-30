import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../resources/app_colors.dart';
import 'text_widget.dart';

class SelectionItem extends StatelessWidget {
  const SelectionItem({
    super.key,
    required this.title,
    required this.isSelected,
  });

  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.black : AppColors.grey,
          ),
        ),
        const Gap(15),
        Expanded(
          child: TextWidget(
            title: title,
            size: 16,
            color: AppColors.textColor,
          ),
        ),
      ],
    );
  }
}
