import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final String name;
  final String emoji;

  Category({
    this.name = '',
    this.emoji = '',
  });

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

// Run 'flutter pub run build_runner build' to create JsonSerializable. 
