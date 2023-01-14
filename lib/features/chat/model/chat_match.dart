import 'package:json_annotation/json_annotation.dart';
import 'last_message.dart';
part 'chat_match.g.dart';

@JsonSerializable()
class ChatMatch {
  int? matchId;
  int? userId;
  String? firstName;
  String? lastName;
  String? image;
  LastMessage? lastMessage;

  ChatMatch({
    this.matchId,
    this.userId,
    this.firstName,
    this.lastName,
    this.image,
    this.lastMessage,
  });

  factory ChatMatch.fromJson(Map<String, dynamic> json) => _$ChatMatchFromJson(json);

  Map<String, dynamic> toJson() => _$ChatMatchToJson(this);
}
