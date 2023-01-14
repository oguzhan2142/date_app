// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMatch _$ChatMatchFromJson(Map<String, dynamic> json) => ChatMatch(
      matchId: json['matchId'] as int?,
      userId: json['userId'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      image: json['image'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : LastMessage.fromJson(json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatMatchToJson(ChatMatch instance) => <String, dynamic>{
      'matchId': instance.matchId,
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'image': instance.image,
      'lastMessage': instance.lastMessage,
    };
