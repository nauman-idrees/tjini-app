import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/provider/auth_provider.dart';
import 'package:tjini_app/ui/resources/app_routes.dart';

import '../../core/di/locator.dart';
import '../../core/enum.dart';
import 'image_widget.dart';

class HeaderWidget extends StatelessWidget {
  final bool? isChildView;
  final VoidCallback? onTap;
  final bool logout;
  const HeaderWidget({
    super.key,
    this.isChildView = false,
    this.onTap,
    this.logout = false,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isChildView!
            ? GestureDetector(
                onTap: onTap,
                child: Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              )
            : logout
            ? authProvider.isLoggingOut
                  ? CircularProgressIndicator()
                  : IconButton(
                      onPressed: () {
                        context.read<AuthProvider>().logout(
                          onSucces: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRoutes.loginRoute,
                              (sc) => false,
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      ),
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
