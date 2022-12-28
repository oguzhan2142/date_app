import 'package:flutter/material.dart';
import 'package:frontend/features/authentication/viewmodel/login_viewmodel.dart';
import 'package:frontend/router/routes.dart';
import 'package:provider/provider.dart';

import '../../../enums/padding_type.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final LoginViewModel viewModel;

  @override
  void initState() {
    viewModel = LoginViewModel(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: PaddingType.PAGE.insets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('login'),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'username'),
                    controller: viewModel.usernameController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'password'),
                    obscureText: true,
                    controller: viewModel.passwordController,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.REGISTER);
              },
              child: const Text('register'),
            ),
            Consumer(
              builder: (context, ref, child) {
                return ElevatedButton(
                  onPressed: viewModel.onLogin,
                  child: const Text('login'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
