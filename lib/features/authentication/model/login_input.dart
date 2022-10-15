import 'package:json_annotation/json_annotation.dart';

part 'login_input.g.dart';

@JsonSerializable()
class LoginInput {
  final String username;
  final String password;

  LoginInput({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginInputToJson(this);
  factory LoginInput.fromJson(Map<String, dynamic> json) => _$LoginInputFromJson(json);
}
