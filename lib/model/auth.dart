import 'package:frontend/model/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auth.g.dart';

@JsonSerializable()
class Auth {
  static Auth? instance;

  final User user;
  final String token;

  Auth({
    required this.user,
    required this.token,
  });

  static bool get isNull => instance == null;

  Map<String, dynamic> toJson() => _$AuthToJson(this);

  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
}
