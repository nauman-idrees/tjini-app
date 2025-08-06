import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, SystemUiOverlayStyle;
import 'package:tjini_app/ui/resources/app_theme.dart';
import 'package:tjini_app/ui/screens/login_screen.dart';
import 'package:tjini_app/ui/screens/parent_profile_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.white),
  );
  runApp(const TjiniApp());
}

class TjiniApp extends StatelessWidget {
  const TjiniApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: ParentProfileScreen(),
      ),
    );
  }
}
