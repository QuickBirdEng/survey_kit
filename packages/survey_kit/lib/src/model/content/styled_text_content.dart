import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';

part 'styled_text_content.g.dart';

/// Content that displays styled text with configurable font size, weight, and
/// decoration. The JSON type identifier is `'styledText'`.
@JsonSerializable()
class StyledTextContent extends Content {
  static const type = 'styledText';

  /// The text string to display.
  final String text;

  /// Font size in logical pixels. Defaults to 16.
  final double fontSize;

  /// Whether the text is bold.
  final bool bold;

  /// Whether the text is italic.
  final bool italic;

  /// Whether the text is underlined.
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
