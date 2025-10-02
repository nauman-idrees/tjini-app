import 'package:flutter/material.dart';
import 'package:tjini_app/ui/screens/app_wrapper_screen.dart';
import 'package:tjini_app/ui/screens/forgot_password_screen.dart';
import 'package:tjini_app/ui/screens/login_screen.dart';
import 'package:tjini_app/ui/screens/parent_profile_screen.dart';

class AppRoutes {
  AppRoutes._();

  //Route Names
  static const initialRoute = '/';
  static const loginRoute = '/login_screen';
  static const forgotPasswordRoute = '/forgot_password_screen';
  static const parentProfileRoute = '/parent_profile_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => const AppWrapperScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case parentProfileRoute:
        return MaterialPageRoute(builder: (_) => ParentProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const AppWrapperScreen());
    }
  }
}
