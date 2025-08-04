import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/enum.dart';
import 'image_widget.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Gap(16),
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
