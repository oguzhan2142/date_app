import 'package:frontend/model/auth_input.dart';

import '../model/auth.dart';

abstract class IAuthenticationRepository {
  Future<Auth?> register({required AuthInput authInput});

  Future<Auth?> login({required AuthInput authInput});
}
