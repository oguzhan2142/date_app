import '../model/auth.dart';

abstract class IAuthenticated {
  String get id => Auth.instance!.user.id;
}
