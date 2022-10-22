import 'package:json_annotation/json_annotation.dart';
import 'image.dart';

part 'match_user.g.dart';

@JsonSerializable()
class MatchUser {
  String? id;
  String? username;
  String? firstName;
  String? lastName;
  int? age;
  List<Image>? images;

  MatchUser({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.age,
    this.images,
  });

  String? getFirstImage() {
    if (images == null) return null;

    if (images!.isEmpty) return null;

    return images?.first.url;
  }

  factory MatchUser.fromJson(Map<String, dynamic> json) => _$MatchUserFromJson(json);

  Map<String, dynamic> toJson() => _$MatchUserToJson(this);
}
