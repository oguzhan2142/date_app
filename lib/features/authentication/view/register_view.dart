import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/enums/padding_type.dart';
import 'package:frontend/features/authentication/provider/register_provider.dart';
import 'package:frontend/features/authentication/viewmodel/register_viewmodel.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  late final RegisterViewModel viewModel;

  @override
  void initState() {
    viewModel = RegisterViewModel(context: context, ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('register view rebuilded');
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: PaddingType.PAGE.insets,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('register'),
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
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'mail'),
                    controller: viewModel.mailController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'first name'),
                    controller: viewModel.firstNameController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'last name'),
                    controller: viewModel.lastNameController,
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                print('register consumer rebuilded');
                final isLoading = ref.watch(registerBtnLoadingProvider);
                return ElevatedButton(
                  onPressed: isLoading ? null : viewModel.onRegister,
                  child: const Text('register'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
