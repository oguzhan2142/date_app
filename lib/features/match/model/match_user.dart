import 'package:json_annotation/json_annotation.dart';
part 'match_user.g.dart';

@JsonSerializable()
class MatchUser {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  int? age;

  MatchUser({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.age,
  });

  factory MatchUser.fromJson(Map<String, dynamic> json) => _$MatchUserFromJson(json);

  Map<String, dynamic> toJson() => _$MatchUserToJson(this);
}
