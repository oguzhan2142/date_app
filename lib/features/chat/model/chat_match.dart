import 'package:json_annotation/json_annotation.dart';
part 'chat_match.g.dart';

@JsonSerializable()
class ChatMatch {
  String? userId;
  String? firstName;
  String? lastName;
  String? image;

  ChatMatch({
    this.userId,
    this.firstName,
    this.lastName,
    this.image,
  });

  Map<String, dynamic> toJson() => _$ChatMatchToJson(this);

  factory ChatMatch.fromJson(Map<String, dynamic> json) => _$ChatMatchFromJson(json);
}
