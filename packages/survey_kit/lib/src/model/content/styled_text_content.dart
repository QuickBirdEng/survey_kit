import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';

part 'styled_text_content.g.dart';

@JsonSerializable()
class StyledTextContent extends Content {
  static const type = 'styledText';

  final String text;
  final double fontSize;
  final bool bold;
  final bool italic;
  final bool underlined;

  const StyledTextContent({
    required this.text,
    this.fontSize = 16,
    this.bold = false,
    this.italic = false,
    this.underlined = false,
  }) : super(contentType: type);

  factory StyledTextContent.fromJson(Map<String, dynamic> json) =>
      _$StyledTextContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StyledTextContentToJson(this);
}
