// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      content: json['content'] as String? ?? '',
      publishedDate: Comment._fromJsonDateTime(json['publishedDate']),
      userUID: json['userUID'] as String? ?? '',
      blogID: json['blogID'] as String? ?? '',
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'content': instance.content,
      'publishedDate': Comment._toJsonDateTime(instance.publishedDate),
      'userUID': instance.userUID,
      'blogID': instance.blogID,
    };
