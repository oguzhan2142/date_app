// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchUser _$MatchUserFromJson(Map<String, dynamic> json) => MatchUser(
      id: json['id'] as String?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
      age: json['age'] as int?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MatchUserToJson(MatchUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'distance': instance.distance,
      'age': instance.age,
      'images': instance.images,
    };
