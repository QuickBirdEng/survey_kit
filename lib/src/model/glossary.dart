import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/model/module.dart';

@JsonSerializable()
class Glossary extends Module {
  const Glossary({
    required super.id,
    required super.title,
    required super.content,
    super.description,
    super.imageUrl,
  });

  factory Glossary.fromJson(Map<String, dynamic> json) => Glossary(
        id: json['id'] as String,
        title: json['title'] as String,
        content: (json['content'] as List<dynamic>)
            .map((dynamic e) => Content.fromJson(e as Map<String, dynamic>))
            .toList(),
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'content': content,
        'description': description,
        'imageUrl': imageUrl,
      };
}
