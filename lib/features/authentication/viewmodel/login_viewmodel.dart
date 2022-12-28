import 'package:flutter/material.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/authentication/repository/i_authentication_repository.dart';
import 'package:provider/provider.dart';

import '../../../manager/cache_manager/cache_manager.dart';
import '../../../manager/cache_manager/cache_tags.dart';
import '../../../model/auth.dart';
import '../../../router/routes.dart';
import '../model/login_input.dart';

class LoginViewModel extends ViewModel {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late final IAuthenticationRepository authenticationRepository;

  LoginViewModel({required super.context}) {
    authenticationRepository = Provider.of<IAuthenticationRepository>(context, listen: false);
  }

  void onLogin() {
    final loginInput = LoginInput(
      username: usernameController.text,
      password: passwordController.text,
    );

    authenticationRepository.login(loginInput: loginInput).then((value) {
      if (value != null) {
        Auth.instance = value;

        CacheManager.instance.put(
          CacheTag.AUTH,
          Auth.instance!.toJson(),
        );
        Navigator.of(context).pushReplacementNamed(Routes.NAVIGATION);

        print('logged in');
      } else {
        print('logged in unsuccessful');
      }
    });
  }
}
