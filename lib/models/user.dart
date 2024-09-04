import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String displayName;
  final String description;
  final String email;
  final String avatarURL;
  @JsonKey(
    fromJson: _fromJsonDateTime,
    toJson: _toJsonDateTime,
  )
  final DateTime? createdDate;

  User({
    this.displayName = '',
    this.description = '',
    this.email = '',
    this.avatarURL = '',
    this.createdDate,
  });

  // Custom fromJson for Timestamp -> DateTime
  static DateTime? _fromJsonDateTime(dynamic value) {
    return value != null ? (value as Timestamp).toDate() : null;
  }

  // Custom toJson for DateTime -> Timestamp
  static dynamic _toJsonDateTime(DateTime? dateTime) {
    return dateTime != null ? Timestamp.fromDate(dateTime) : null;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

// Run 'flutter pub run build_runner build' to create JsonSerializable. 
