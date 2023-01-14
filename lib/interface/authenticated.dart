import '../model/auth.dart';

abstract class IAuthenticated {
  int? get id => Auth.instance?.user.id;
}
