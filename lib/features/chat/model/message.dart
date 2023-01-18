import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  int? id;
  int? matchId;
  int? senderUserId;
  int? receiveUserId;
  String? content;
  String? date;

  Message({
    this.id,
    this.matchId,
    this.senderUserId,
    this.receiveUserId,
    this.content,
    this.date,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
