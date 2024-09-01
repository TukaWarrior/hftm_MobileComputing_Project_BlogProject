import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'blogpost.g.dart';

@JsonSerializable()
class BlogPost {
  // final String id;
  final String title;
  final String content;
  final String category;
  // Use custom converter for Timestamp
  // @JsonKey(
  //   fromJson: _fromJsonTimestamp,
  //   toJson: _toJsonTimestamp,
  // )
  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? publishedDate;
  final String imageURL;
  final String audioURL;
  final String userUID;

  BlogPost({
    // this.id = '',
    this.title = '',
    this.content = '',
    this.category = '',
    this.publishedDate,
    this.imageURL = '',
    this.audioURL = '',
    this.userUID = '',
  });

  // Custom fromJson for Timestamp -> DateTime
  static DateTime? _fromJsonDateTime(dynamic value) {
    return value != null ? (value as Timestamp).toDate() : null;
  }

  // Custom toJson for DateTime -> Timestamp
  static dynamic _toJsonDateTime(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }

// // Custom fromJson for Timestamp -> Timestamp
//   static Timestamp? _fromJsonTimestamp(dynamic value) {
//     return value != null ? value as Timestamp : null;
//   }

//   // Custom toJson for Timestamp -> Timestamp
//   static dynamic _toJsonTimestamp(Timestamp? timestamp) => timestamp;

  factory BlogPost.fromJson(Map<String, dynamic> json) => _$BlogPostFromJson(json);
  Map<String, dynamic> toJson() => _$BlogPostToJson(this);
}
