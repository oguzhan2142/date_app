import 'package:flutter/material.dart';
import 'package:frontend/base/view_model.dart';
import 'package:frontend/features/authentication/provider/register_provider.dart';
import 'package:frontend/features/authentication/provider/repository_provider.dart';

import '../../../model/auth.dart';
import '../model/auth_input.dart';

class RegisterViewModel extends ViewModel {
  final usernameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mailController = TextEditingController();
  final firstNameController = TextEditingController();
  final passwordController = TextEditingController();
  RegisterViewModel({required super.context, required super.ref});

  void onRegister() async {
    final authInput = AuthInput(
      username: usernameController.text,
      password: passwordController.text,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      mail: mailController.text,
    );
    ref.read(registerBtnLoadingProvider.state).state = true;
    Auth? auth = await ref.read(authRepositoryProvider).register(authInput: authInput);

    if (auth != null) {
      Auth.instance = auth;
      print('authenticated');
    } else {
      print('error with authentication');
    }
    ref.read(registerBtnLoadingProvider.state).state = false;
  }
}
