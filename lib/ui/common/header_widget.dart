import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/enum.dart';
import 'image_widget.dart';

class HeaderWidget extends StatelessWidget {
  final bool? isChildView;
  final VoidCallback? onTap;
  const HeaderWidget({super.key, this.isChildView = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isChildView!
            ? GestureDetector(
          onTap: onTap,
          child: Icon(Icons.arrow_back, size: 25,),
        )
            : Gap(16),
        ImageWidget(
          imageSrc: 'assets/ic_text_logo.png',
          type: ImageType.asset,
        ),
        ImageWidget(
          imageSrc: 'assets/ic_location_logo.png',
          type: ImageType.asset,
        ),
      ],
    );
  }
}
