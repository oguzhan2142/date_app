import 'package:flutter/material.dart';
import 'package:frontend/base/view_model.dart';

import '../../../manager/cache_manager/cache_manager.dart';
import '../../../manager/cache_manager/cache_tags.dart';
import '../../../model/auth.dart';
import '../../../router/routes.dart';

class ProfileViewModel extends ViewModel {
  ProfileViewModel({required super.context, required super.ref});

  void signOut() {
    Auth.instance = null;
    CacheManager.instance.clear(CacheTag.AUTH);
    Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
  }

  void onTapPhotos() {
    Navigator.pushNamed(context, Routes.PHOTOS);
  }
}
