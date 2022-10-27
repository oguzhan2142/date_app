import 'package:frontend/features/profile/model/user_photo.dart';

abstract class IProfileRepository {
  Future<List<UserPhoto>?> getUserPhotos({required String userId});

  Future<bool> updateOrder({
    required String userId,
    required int index,
    required String key,
  });

  Future<UserPhoto?> uploadPhoto({
    required String userId,
    required String key,
    required String filePath,
  });

  Future<bool> deletePhoto({
    required String userId,
    required String photoId,
  });
}
