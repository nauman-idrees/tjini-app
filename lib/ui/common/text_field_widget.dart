import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../resources/app_colors.dart';

class TextFieldWidget extends HookWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    this.hint,
    this.isPassword = false,
    this.validator,
    this.isEnabled = true,
    this.autoValidate = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textInputAction,
  });
  final String? hint;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final bool isEnabled;
  final bool autoValidate;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final isPasswordHidded = useState(true);
    return SizedBox(
      height: 80,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && isPasswordHidded.value,
        validator: validator,
        enabled: isEnabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        cursorColor: AppColors.primaryColor,
        autovalidateMode: autoValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled,
        decoration: InputDecoration(
          counterText: " ",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.grey200,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.grey300,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          labelText: hint,
          labelStyle: TextStyle(
            color: AppColors.primaryColor.withValues(alpha: 0.5),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () =>
                      isPasswordHidded.value = !isPasswordHidded.value,
                  icon: Icon(
                    isPasswordHidded.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
