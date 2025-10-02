import 'package:flutter/material.dart';
import 'package:tjini_app/ui/common/text_widget.dart';

class ViewerScreen extends StatelessWidget {
  const ViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextWidget(title: "Coming Soon"),
      ),
    );
  }
}
