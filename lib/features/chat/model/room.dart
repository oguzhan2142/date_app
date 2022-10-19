import 'package:json_annotation/json_annotation.dart';
import 'contact.dart';
import 'message.dart';

part 'room.g.dart';

@JsonSerializable()
class Room {
  String? id;
  String? createdAt;
  Message? message;
  Contact? contact;

  Room({
    this.id,
    this.createdAt,
    this.message,
    this.contact,
  });

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}
