import 'package:flutter/material.dart';

class RoundAction extends StatelessWidget {
  const RoundAction({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: const CircleBorder(),
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Icon(
            icon,
            size: 15,
          ),
        ),
      ),
    );
  }
}
