import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tjini_app/provider/auth_provider.dart';
import 'package:tjini_app/ui/common/main_button.dart';
import 'package:tjini_app/ui/common/text_widget.dart';
import 'package:tjini_app/ui/resources/app_colors.dart';
import 'package:tjini_app/ui/resources/app_routes.dart';

import '../../core/extensions.dart';
import '../common/header_widget.dart';
import '../common/text_field_widget.dart';

class ForgotPasswordScreen extends HookWidget {
  ForgotPasswordScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: "john@doe.com");
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final passwordMode = useState(false);
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
                    if (!passwordMode.value)
                      Column(
                        children: [
                          TextWidget(
                            title:
                                "Veuillez saisir votre email pour réinitialiser votre mot de passe"
                                    .hardcoded(),
                            size: 16,
                            color: Colors.black,
                            weight: FontWeight.w400,
                          ),
                          const Gap(20),
                          TextFieldWidget(
                            controller: emailController,
                            hint: 'Email'.hardcoded(),
                            validator: (value) {
                              return value.validateEmail();
                            },
                          ),
                        ],
                      ),
                    if (passwordMode.value)
                      Column(
                        children: [
                          TextFieldWidget(
                            controller: passwordController,
                            hint: 'Mot de passe'.hardcoded(),
                            isPassword: true,
                            validator: (value) {
                              return value.validatePassword();
                            },
                          ),
                          TextFieldWidget(
                            controller: confirmPasswordController,
                            hint: 'Mot de passe'.hardcoded(),
                            isPassword: true,
                            validator: (value) {
                              return value.validateConfirmPassword(
                                passwordController.text,
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const Spacer(),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: double.infinity / 2,
                    child: MainButton(
                      title: passwordMode.value
                          ? "fait".hardcoded()
                          : "Soumettre".hardcoded(),
                      isLoading: authProvider.isLoading,
                      onPressed: authProvider.isLoading
                          ? () {}
                          : () {
                              if (formKey.currentState!.validate()) {
                                if (passwordMode.value) {
                                  context.read<AuthProvider>().resetPassword(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                } else {
                                  passwordMode.value = true;
                                }
                              }
                            },
                      buttonColor: AppColors.primaryColor,
                    ),
                  );
                },
              ),
              Gap(100),
            ],
          ),
        ),
      ),
    );
  }
}
