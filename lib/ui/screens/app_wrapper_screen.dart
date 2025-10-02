import 'package:flutter/material.dart';
import 'package:tjini_app/core/helper/shared_preferences_helper.dart';
import 'package:tjini_app/ui/screens/login_screen.dart';

import '../../core/di/locator.dart';
import 'parent_profile_screen.dart';

class AppWrapperScreen extends StatelessWidget {
  const AppWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<HomeState> getHomeState() async {
      HomeState homeState = HomeState(isLoggedIn: false);
      await Future.delayed(const Duration(seconds: 2));
      bool? isLoggedIn = locator<SharedPreferencesHelper>().isLoggedIn();
      return HomeState(isLoggedIn: isLoggedIn);
    }

    return FutureBuilder(
      future: getHomeState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _showLoading(); // Loading state
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error')),
          ); // Error state
        } else if (snapshot.hasData) {
          return !snapshot.data!.isLoggedIn
              ? ParentProfileScreen() // Loged In State
              : LoginScreen();
        } else {
          return _showLoading(); // Default state
        }
      },
    );
  }

  Scaffold _showLoading() {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class HomeState {
  final bool isLoggedIn;

  HomeState({
    required this.isLoggedIn,
  });

  HomeState copyWith({
    bool? isLoggedIn,
    bool? isRatingGiven,
  }) {
    return HomeState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}
