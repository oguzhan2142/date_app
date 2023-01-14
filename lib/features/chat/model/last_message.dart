import 'package:json_annotation/json_annotation.dart';
part 'last_message.g.dart';

@JsonSerializable()
class LastMessage {
  String? content;
  String? date;

  LastMessage({
    this.content,
    this.date,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => _$LastMessageFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageToJson(this);
}
