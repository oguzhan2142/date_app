import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/features/profile/viewmodel/profile_viewmodel.dart';
import 'package:frontend/gen/assets.gen.dart';
import 'package:frontend/model/auth.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView> {
  late final ProfileViewModel viewModel;

  @override
  void initState() {
    viewModel = ProfileViewModel(context: context, ref: ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 80,
            child: Assets.icons.userPlaceholder.image(),
          ),
          Text(Auth.instance?.user.firstName ?? ''),
          const SizedBox(height: 20),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {},
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: const Icon(Icons.photo),
            title: const Text('Photos'),
            onTap: viewModel.onTapPhotos,
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: viewModel.signOut,
            trailing: const Icon(Icons.chevron_right),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
