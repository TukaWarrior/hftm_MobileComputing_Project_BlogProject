import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final String content;
  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? publishedDate;
  final String userUID;
  final String blogID;

  Comment({
    this.content = '',
    this.publishedDate,
    this.userUID = '',
    this.blogID = '',
  });

  // Custom fromJson for Timestamp -> DateTime
  static DateTime? _fromJsonDateTime(dynamic value) {
    return value != null ? (value as Timestamp).toDate() : null;
  }

  // Custom toJson for DateTime -> Timestamp
  static dynamic _toJsonDateTime(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

// Run 'flutter pub run build_runner build' to create JsonSerializable. 
