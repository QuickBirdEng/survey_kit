import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/content/content.dart';

part 'text_content.g.dart';

@JsonSerializable()
class TextContent extends Content {
  final String text;

  const TextContent({
    required super.id,
    required this.text,
  });

  factory TextContent.fromJson(Map<String, dynamic> json) =>
      _$TextContentFromJson(json);

  Map<String, dynamic> toJson() => _$TextContentToJson(this);
}
