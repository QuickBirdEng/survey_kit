import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'text_content.g.dart';

/// Content that displays a plain text string.
/// The JSON type identifier is `'text'`.
@JsonSerializable()
class TextContent extends Content {
  static const type = 'text';

  /// The text string to display.
  final String text;

  /// Font size in logical pixels. Defaults to 16.
  final double fontSize;

  /// Horizontal alignment of the text. Defaults to [TextAlign.center].
  final TextAlign textAlign;

  const TextContent({
    required this.text,
    this.fontSize = 16,
    this.textAlign = TextAlign.center,
    super.id,
  }) : super(contentType: type);

  factory TextContent.fromJson(Map<String, dynamic> json) =>
      _$TextContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TextContentToJson(this);
}
