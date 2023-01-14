import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? mail;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mail,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
