import 'package:frontend/features/authentication/model/login_input.dart';

import '../../../model/auth.dart';
import '../model/auth_input.dart';

abstract class IAuthenticationRepository {
  Future<Auth?> register({required AuthInput authInput});

  Future<Auth?> login({required LoginInput loginInput});
}
