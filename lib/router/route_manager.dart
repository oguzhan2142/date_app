import 'package:flutter/material.dart';
import 'package:frontend/features/match/view/match_view.dart';
import 'package:frontend/features/onboarding/view/splash_view.dart';
import 'package:go_router/go_router.dart';

class RouteManager {
  static final RouteManager instance = RouteManager._();
  RouteManager._();

  final GoRouter router = GoRouter(
    initialLocation: '/match',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: '/match',
        name: '/match',
        builder: (BuildContext context, GoRouterState state) {
          return const MatchView();
        },
      ),
    ],
  );
}
