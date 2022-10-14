import 'package:json_annotation/json_annotation.dart';

part 'match_user.g.dart';

@JsonSerializable()
class MatchUser {
  final String? username;

  MatchUser({
    this.username,
  });

  Map<String, dynamic> toJson() => _$MatchUserToJson(this);
  factory MatchUser.fromJson(Map<String, dynamic> json) => _$MatchUserFromJson(json);
}
