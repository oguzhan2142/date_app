import 'package:json_annotation/json_annotation.dart';

part 'user_photo.g.dart';

@JsonSerializable()
class UserPhoto {
  final String? id;
  final String? key;
  final String? url;

  UserPhoto({
    this.id,
    this.key,
    this.url,
  });

  Map<String, dynamic> toJson() => _$UserPhotoToJson(this);
  factory UserPhoto.fromJson(Map<String, dynamic> json) => _$UserPhotoFromJson(json);
}
