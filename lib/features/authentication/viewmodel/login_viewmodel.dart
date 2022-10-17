import 'package:flutter/material.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/authentication/model/login_input.dart';
import 'package:frontend/features/authentication/provider/login_provider.dart';
import 'package:frontend/features/authentication/provider/repository_provider.dart';
import 'package:frontend/manager/cache_manager/cache_manager.dart';
import 'package:frontend/manager/cache_manager/cache_tags.dart';
import 'package:go_router/go_router.dart';

import '../../../model/auth.dart';

class LoginViewModel extends ViewModel {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginViewModel({required super.context, required super.ref});

  void onLogin() {
    ref.read(loginBtnLoadingProvider.state).state = true;
    final loginInput = LoginInput(
      username: usernameController.text,
      password: passwordController.text,
    );
    ref.read(authRepositoryProvider).login(loginInput: loginInput).then((value) {
      if (value != null) {
        Auth.instance = value;

        CacheManager.instance.put(
          CacheTag.AUTH,
          Auth.instance!.toJson(),
        );
        GoRouter.of(context).replaceNamed('/match');

        print('logged in');
      } else {
        print('logged in unsuccessful');
      }

      ref.read(loginBtnLoadingProvider.state).state = false;
    });
  }
}
