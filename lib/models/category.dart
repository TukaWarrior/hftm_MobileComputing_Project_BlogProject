import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String documentID;
  final String name;
  final String emoji;

  Category({
    this.documentID = '',
    this.name = '',
    this.emoji = '',
  });

  // Constructor to create Category from Firestore DocumentSnapshot
  factory Category.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Category(
      documentID: doc.id,
      name: data['name'] ?? '',
      emoji: data['emoji'] ?? '',
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

// Run 'flutter pub run build_runner build' to create JsonSerializable. 
