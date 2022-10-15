import 'package:json_annotation/json_annotation.dart';
part 'auth_input.g.dart';

@JsonSerializable()
class AuthInput {
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final String mail;

  AuthInput({
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.mail,
  });

  factory AuthInput.fromJson(Map<String, dynamic> json) => _$AuthInputFromJson(json);

  Map<String, dynamic> toJson() => _$AuthInputToJson(this);
}
