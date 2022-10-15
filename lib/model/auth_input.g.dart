// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInput _$AuthInputFromJson(Map<String, dynamic> json) => AuthInput(
      username: json['username'] as String,
      password: json['password'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      mail: json['mail'] as String,
    );

Map<String, dynamic> _$AuthInputToJson(AuthInput instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mail': instance.mail,
    };
