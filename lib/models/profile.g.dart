// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) => Profile(
      documentID: json['documentID'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatarURL: json['avatarURL'] as String? ?? '',
      createdDate: Profile._fromJsonDateTime(json['createdDate']),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'documentID': instance.documentID,
      'displayName': instance.displayName,
      'description': instance.description,
      'email': instance.email,
      'avatarURL': instance.avatarURL,
      'createdDate': Profile._toJsonDateTime(instance.createdDate),
    };
