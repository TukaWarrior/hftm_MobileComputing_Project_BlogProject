// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogpost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogPost _$BlogPostFromJson(Map<String, dynamic> json) => BlogPost(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      imageURL: json['imageURL'] as String? ?? '',
      audioURL: json['audioURL'] as String? ?? '',
      userUID: json['userUID'] as String? ?? '',
    );

Map<String, dynamic> _$BlogPostToJson(BlogPost instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'imageURL': instance.imageURL,
      'audioURL': instance.audioURL,
      'userUID': instance.userUID,
    };
