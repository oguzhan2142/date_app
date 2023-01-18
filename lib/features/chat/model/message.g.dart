// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int?,
      matchId: json['matchId'] as int?,
      senderUserId: json['senderUserId'] as int?,
      receiveUserId: json['receiveUserId'] as int?,
      content: json['content'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'matchId': instance.matchId,
      'senderUserId': instance.senderUserId,
      'receiveUserId': instance.receiveUserId,
      'content': instance.content,
      'date': instance.date,
    };
