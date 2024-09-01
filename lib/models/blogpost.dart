import 'package:json_annotation/json_annotation.dart';

part 'blogpost.g.dart';

@JsonSerializable()
class BlogPost {
  final String id;
  final String title;
  final String content;
  final String imageURL;
  final String audioURL;
  final String userUID;

  BlogPost({
    this.id = '',
    this.title = '',
    this.content = '',
    this.imageURL = '',
    this.audioURL = '',
    this.userUID = '',
  });
  factory BlogPost.fromJson(Map<String, dynamic> json) => _$BlogPostFromJson(json);
  Map<String, dynamic> toJson() => _$BlogPostToJson(this);
}
