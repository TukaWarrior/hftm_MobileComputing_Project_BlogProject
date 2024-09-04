// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      displayName: json['displayName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatarURL: json['avatarURL'] as String? ?? '',
      createdDate: User._fromJsonDateTime(json['createdDate']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'description': instance.description,
      'email': instance.email,
      'avatarURL': instance.avatarURL,
      'createdDate': User._toJsonDateTime(instance.createdDate),
    };
