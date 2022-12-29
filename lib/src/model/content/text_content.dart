import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'text_content.g.dart';

@JsonSerializable()
class TextContent extends Content {
  final String text;
  final double fontSize;
  final TextAlign textAlign;

  const TextContent({
    required this.text,
    this.fontSize = 16,
    this.textAlign = TextAlign.center,
    super.id,
  });

  factory TextContent.fromJson(Map<String, dynamic> json) =>
      _$TextContentFromJson(json);

  Map<String, dynamic> toJson() => _$TextContentToJson(this);
}
