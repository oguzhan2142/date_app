import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/view/login_view.dart';
import 'package:frontend/features/authentication/view/register_view.dart';
import 'package:frontend/features/match/view/match_view.dart';
import 'package:frontend/features/onboarding/view/splash_view.dart';
import 'package:frontend/model/auth.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  RouteManager._();
  void init(String initialLocation) {
    router = GoRouter(
      initialLocation: initialLocation,
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          name: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SplashView();
          },
        ),
        GoRoute(
          path: '/register',
          builder: (BuildContext context, GoRouterState state) {
            return const RegisterView();
          },
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginView();
          },
        ),
        GoRoute(
          path: '/match',
          name: '/match',
          redirect: _redirect,
          builder: (BuildContext context, GoRouterState state) {
            return const MatchView();
          },
        ),
      ],
    );
  }

  FutureOr<String?> _redirect(context, state) {
    if (Auth.isNull) {
      return '/login';
    }
    return null;
  }

  static final RouteManager instance = RouteManager._();

  late final GoRouter router;
}
