// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      userId: json['userId'] as int?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'userId': instance.userId,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'id': instance.id,
    };
