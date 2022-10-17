import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/manager/cache_manager/cache_manager.dart';
import 'package:frontend/manager/cache_manager/cache_tags.dart';
import 'package:frontend/router/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  print(RouteManager.instance.initialLocation);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteManager.instance.initialLocation,
        routes: RouteManager.instance.routes,
        // home: RouteManager.instance.getHome(),
        title: 'Material App',
      ),
    );
  }
}
