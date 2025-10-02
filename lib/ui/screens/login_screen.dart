import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:tjini_app/core/enum.dart';
import 'package:tjini_app/provider/auth_provider.dart';
import 'package:tjini_app/provider/user_provider.dart';
import 'package:tjini_app/ui/common/main_button.dart';
import 'package:tjini_app/ui/resources/app_colors.dart';
import 'package:tjini_app/ui/resources/app_routes.dart';

import '../../core/extensions.dart';
import '../common/header_widget.dart';
import '../common/text_field_widget.dart';
import '../common/text_widget.dart';

class LoginScreen extends HookWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: "john@doe.com");
    final passwordController = useTextEditingController(text: "Password@1234");
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
                      controller: emailController,
                      hint: 'Email'.hardcoded(),
                      validator: (value) {
                        return value.validateEmail();
                      },
                    ),
                    const Gap(10),
                    TextFieldWidget(
                      controller: passwordController,
                      hint: 'Mot de passe'.hardcoded(),
                      isPassword: true,
                      validator: (value) {
                        return value.validatePassword();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.forgotPasswordRoute,
                            );
                          },
                          child: TextWidget(
                            title: 'Mot de passe oublié ?'.hardcoded(),
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                          ),
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
                      title: "Connection".hardcoded(),
                      isLoading: authProvider.isLoading,
                      onPressed: authProvider.isLoading
                          ? () {}
                          : () {
                              if (formKey.currentState!.validate()) {
                                context.read<AuthProvider>().login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  onSuccess: (user) {
                                    context.read<UserProvider>().setUser(user);
                                    Permission.notification.request();
                                    if (user.roles.any(
                                      (role) => role.name == UserRole.parent,
                                    )) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.parentProfileRoute,
                                      );
                                    }

                                    if (user.roles.any(
                                      (role) =>
                                          role.name == UserRole.dispatcher,
                                    )) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.establishmentProfileRoute,
                                      );
                                    }

                                    if (user.roles.any(
                                      (role) => role.name == UserRole.viewer,
                                    )) {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.viewerProfileRoute,
                                      );
                                    }
                                  },
                                );
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
