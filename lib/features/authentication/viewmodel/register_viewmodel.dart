import 'package:flutter/material.dart';
import 'package:frontend/base/view_model.dart';

class RegisterViewModel extends ViewModel {
  final usernameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mailController = TextEditingController();
  final firstNameController = TextEditingController();
  final passwordController = TextEditingController();
  RegisterViewModel();

  void onRegister() {
    // final authInput = AuthInput(
    //   username: usernameController.text,
    //   password: passwordController.text,
    //   firstName: firstNameController.text,
    //   lastName: lastNameController.text,
    //   mail: mailController.text,
    // );
    // ref.read(registerBtnLoadingProvider.state).state = true;
    // ref.read(authRepositoryProvider).register(authInput: authInput).then((auth) {
    //   if (auth != null) {
    //     Auth.instance = auth;
    //     Navigator.of(context).pushReplacementNamed(Routes.NAVIGATION);
    //     print('authenticated');
    //   } else {
    //     print('error with authentication');
    //   }
    //   ref.read(registerBtnLoadingProvider.state).state = false;
    // });
  }
}
