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
}
