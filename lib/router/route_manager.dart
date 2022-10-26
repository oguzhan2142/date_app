import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/view/login_view.dart';
import 'package:frontend/features/authentication/view/register_view.dart';
import 'package:frontend/features/onboarding/view/splash_view.dart';
import 'package:frontend/features/profile/view/photos_view.dart';
import 'package:frontend/features/profile/view/settings_view.dart';
import 'package:frontend/model/auth.dart';
import 'package:frontend/router/routes.dart';

import '../features/navigation_bar/view/navigation_view.dart';

class RouteManager {
  RouteManager._();

  final Map<String, Widget Function(BuildContext)> routes = {
    Routes.SETTINGS: (context) => const SettingsView(),
    Routes.LOGIN: (context) => const LoginView(),
    Routes.REGISTER: (context) => const RegisterView(),
    Routes.SPLASH: (context) => const SplashView(),
    Routes.NAVIGATION: (context) => const NavigationView(),
    Routes.PHOTOS: (context) => const PhotosView(),
  };

  Widget getHome() {
    if (initialLocation == Routes.NAVIGATION) {
      return const NavigationView();
    }

    return const LoginView();
  }

  late final String initialLocation;

  FutureOr<String?> _redirect(context, state) {
    if (Auth.isNull) {
      return '/login';
    }
    return null;
  }

  static final RouteManager instance = RouteManager._();
}
