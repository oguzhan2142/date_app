import 'package:frontend/features/profile/model/user_photo.dart';

abstract class IProfileRepository {
  Future<List<UserPhoto>?> getUserPhotos({required int userId});

  Future<bool> updateOrder({
    required int userId,
    required int index,
    required String key,
  });

  Future<UserPhoto?> uploadPhoto({
    required int userId,
    required String key,
    required String filePath,
  });

  Future<bool> deletePhoto({
    required int userId,
    required String photoId,
  });
}
