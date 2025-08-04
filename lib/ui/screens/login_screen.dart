import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tjini_app/ui/common/main_button.dart';
import 'package:tjini_app/ui/resources/app_colors.dart';

import '../../core/extensions.dart';
import '../common/header_widget.dart';
import '../common/text_field_widget.dart';
import '../common/text_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              HeaderWidget(),
              const Spacer(),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      controller: TextEditingController(),
                      hint: 'Email'.hardcoded(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email est requis'.hardcoded();
                        } else if (!value.contains('@')) {
                          return 'Email invalide'.hardcoded();
                        }
                        return null;
                      },
                    ),
                    const Gap(10),
                    TextFieldWidget(
                      controller: TextEditingController(),
                      hint: 'Mot de passe'.hardcoded(),
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mot de passe est requis'.hardcoded();
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextWidget(
                          title: 'Mot de passe oublié ?'.hardcoded(),
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity / 2,
                child: MainButton(
                  title: "Connection".hardcoded(),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  buttonColor: AppColors.primaryColor,
                ),
              ),
              Gap(100),
            ],
          ),
        ),
      ),
    );
  }
}
