import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  int? userId;
  String? content;
  String? createdAt;
  int? id;

  Message({
    this.userId,
    this.content,
    this.createdAt,
    this.id,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
