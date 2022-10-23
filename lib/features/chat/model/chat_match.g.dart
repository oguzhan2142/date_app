// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMatch _$ChatMatchFromJson(Map<String, dynamic> json) => ChatMatch(
      userId: json['userId'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ChatMatchToJson(ChatMatch instance) => <String, dynamic>{
      'userId': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'image': instance.image,
    };
