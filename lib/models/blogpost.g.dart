// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blogpost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogPost _$BlogPostFromJson(Map<String, dynamic> json) => BlogPost(
      documentID: json['documentID'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      category: json['category'] as String? ?? '',
      publishedDate: BlogPost._fromJsonDateTime(json['publishedDate']),
      imageURL: json['imageURL'] as String? ?? '',
      audioURL: json['audioURL'] as String? ?? '',
      userUID: json['userUID'] as String? ?? '',
    );

Map<String, dynamic> _$BlogPostToJson(BlogPost instance) => <String, dynamic>{
      'documentID': instance.documentID,
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'publishedDate': BlogPost._toJsonDateTime(instance.publishedDate),
      'imageURL': instance.imageURL,
      'audioURL': instance.audioURL,
      'userUID': instance.userUID,
    };
