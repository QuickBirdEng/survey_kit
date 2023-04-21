import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/view/widget/content/section_widget.dart';

part 'section_content.g.dart';

@JsonSerializable()
class SectionContent extends Content {
  static const type = 'section';

  final StyledText title;
  final StyledText subtitle;
  final StyledText text;

  const SectionContent({
    required this.title,
    required this.subtitle,
    required this.text,
  }) : super(contentType: type);

  factory SectionContent.fromJson(Map<String, dynamic> json) =>
      _$SectionContentFromJson(json);

  Map<String, dynamic> toJson() => _$SectionContentToJson(this);

  @override
  Widget createWidget() {
    return SectionWidget(sectionContent: this);
  }
}

@JsonSerializable()
class StyledText {
  final String text;
  final double fontSize;
  final bool bold;
  final bool italic;
  final bool underlined;

  const StyledText({
    required this.text,
    this.fontSize = 16,
    this.bold = false,
    this.italic = false,
    this.underlined = false,
  });

  factory StyledText.fromJson(Map<String, dynamic> json) =>
      _$StyledTextFromJson(json);

  Map<String, dynamic> toJson() => _$StyledTextToJson(this);
}

extension SectionContentExt on SectionContent {
  List<StyledText> get toList {
    return [title, subtitle, text];
  }
}
