import 'package:flutter/material.dart';
import 'package:frontend/features/match/repository/i_match_repository.dart';

import 'package:frontend/manager/cache_manager/cache_manager.dart';
import 'package:frontend/manager/cache_manager/cache_tags.dart';
import 'package:frontend/manager/request_manager/request_manager.dart';
import 'package:frontend/manager/theme/theme_manager.dart';
import 'package:frontend/router/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/match/repository/match_repository.dart';
import 'model/auth.dart';
import 'router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CacheManager.instance.init(await SharedPreferences.getInstance());

  var authJson = CacheManager.instance.get(CacheTag.AUTH);

  if (authJson != null) {
    var auth = Auth.fromJson(authJson);

    Auth.instance = auth;
    RouteManager.instance.initialLocation = Routes.NAVIGATION;
  } else {
    RouteManager.instance.initialLocation = Routes.LOGIN;
  }

  runApp(MultiProvider(
    providers: [
      Provider<IMatchRepository>(
        create: (context) => MatchRepository(
          requestManager: RequestManager('http://localhost:3000'),
        ),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteManager.instance.initialLocation,
      routes: RouteManager.instance.routes,
      theme: ThemeManager.instance.lightTheme,
      // home: RouteManager.instance.getHome(),
      title: 'Material App',
    );
  }
}
