import 'package:frontend/features/profile/model/user_photo.dart';

abstract class IProfileRepository {
  Future<List<UserPhoto>?> getUserPhotos({required String userId});
}
