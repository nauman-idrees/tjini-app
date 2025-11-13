import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.buttonColor,
    this.textColor,
    required this.title,
    required this.onPressed,
    this.isDisabled = false,
    this.isLoading = false,
  });

  final String title;
  final Color? buttonColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final bool isDisabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isDisabled ? 0.3 : 1,
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: isDisabled ? () {} : onPressed,
          style: ButtonStyle(
            backgroundColor: buttonColor != null
                ? WidgetStateProperty.all(buttonColor)
                : null,
          ),
          child: isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(color: textColor),
                ),
        ),
      ),
    );
  }
}
