import 'package:frontend/base/view_model.dart';

import '../../../manager/cache_manager/cache_manager.dart';
import '../../../manager/cache_manager/cache_tags.dart';
import '../../../model/auth.dart';

class ProfileViewModel extends ViewModel {
  ProfileViewModel();

  void signOut() {
    Auth.instance = null;
    CacheManager.instance.clear(CacheTag.AUTH);
    // Navigator.of(context).pushReplacementNamed(Routes.LOGIN);
  }

  void onTapPhotos() {
    // Navigator.pushNamed(context, Routes.PHOTOS);
  }
}
