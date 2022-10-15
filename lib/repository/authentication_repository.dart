import 'package:frontend/enums/request_type.dart';
import 'package:frontend/features/authentication/model/login_input.dart';
import 'package:frontend/model/auth.dart';
import 'package:frontend/repository/base_repository.dart';
import 'package:frontend/repository/i_authentication_repository.dart';

import '../features/authentication/model/auth_input.dart';

class AuthenticationRepository extends BaseRepository implements IAuthenticationRepository {
  AuthenticationRepository({required super.requestManager});

  @override
  Future<Auth?> login({required LoginInput loginInput}) {
    return requestManager.getSingle<Auth?>(
      path: '/api/user/login',
      requestType: RequestType.POST,
      body: loginInput.toJson(),
      converter: (json) => Auth.fromJson(json),
    );
  }

  @override
  Future<Auth?> register({required AuthInput authInput}) {
    return requestManager.getSingle<Auth?>(
      path: '/api/user/register',
      requestType: RequestType.POST,
      body: authInput.toJson(),
      converter: (json) => Auth.fromJson(json),
    );
  }
}
