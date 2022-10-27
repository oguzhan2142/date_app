import 'package:dio/dio.dart';
import 'package:frontend/base/base_repository.dart';
import 'package:frontend/enums/request_type.dart';
import 'package:frontend/features/profile/model/user_photo.dart';
import 'package:frontend/features/profile/repository/i_profile_repository.dart';

class ProfileRepository extends BaseRepository implements IProfileRepository {
  ProfileRepository({required super.requestManager});

  @override
  Future<List<UserPhoto>?> getUserPhotos({required String userId}) {
    return requestManager.getList(
      path: '/api/photo/$userId',
      requestType: RequestType.GET,
      converter: (json) => UserPhoto.fromJson(json),
    );
  }

  @override
  Future<bool> updateOrder({
    required String userId,
    required int index,
    required String key,
  }) {
    return requestManager.getResult(
      path: '/api/photo',
      requestType: RequestType.PUT,
      queryParameters: {
        'userId': userId,
        'index': index,
        'key': key,
      },
    );
  }

  @override
  Future<UserPhoto?> uploadPhoto({
    required String userId,
    required String key,
    required String filePath,
  }) async {
    var file = await MultipartFile.fromFile(filePath, filename: key);

    var formData = FormData.fromMap({'image': file});
    var result = await requestManager.getSingle(
      path: '/api/photo',
      requestType: RequestType.POST,
      converter: (json) => UserPhoto.fromJson(json),
      body: formData,
      queryParameters: {
        'userId': userId,
        'key': key,
      },
    );
    return result;
  }
}
