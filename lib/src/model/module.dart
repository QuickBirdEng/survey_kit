import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/model/glossary.dart';
import 'package:survey_kit/src/model/step.dart';

@JsonSerializable()
abstract class Module {
  final String id;
  final String title;
  final List<Content> content;
  final String? description;
  final String? imageUrl;

  const Module({
    required this.id,
    required this.title,
    required this.content,
    this.description,
    this.imageUrl,
  });

  factory Module.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    switch (type) {
      case 'glossary':
        return Glossary.fromJson(json);
      case 'step':
        return Step.fromJson(json);

      default:
        throw Exception('Unknown type: $type');
    }
  }
}
