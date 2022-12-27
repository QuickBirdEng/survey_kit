import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/module.dart';

part 'glossary.g.dart';

@JsonSerializable()
class Glossary extends Module {
  const Glossary({
    required super.id,
    required super.title,
    required super.content,
    super.description,
    super.imageUrl,
  });

  factory Glossary.fromJson(Map<String, dynamic> json) =>
      _$GlossaryFromJson(json);
  Map<String, dynamic> toJson() => _$GlossaryToJson(this);
}
