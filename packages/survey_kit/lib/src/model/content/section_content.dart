import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';

part 'section_content.g.dart';

/// Content that displays a structured section with a title, subtitle, and body
/// text, each as a [StyledTextContent]. The JSON type identifier is `'section'`.
@JsonSerializable(explicitToJson: true)
class SectionContent extends Content {
  static const type = 'section';

  /// The section title text.
  final StyledTextContent title;

  /// The section subtitle text.
  final StyledTextContent subtitle;

  /// The section body text.
  final StyledTextContent text;

  const SectionContent({
    required this.title,
    required this.subtitle,
    required this.text,
  }) : super(contentType: type);

  factory SectionContent.fromJson(Map<String, dynamic> json) =>
      _$SectionContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    ..._$SectionContentToJson(this),
    'type': type,
  };
}

extension SectionContentExt on SectionContent {
  /// Returns [title], [subtitle], and [text] as an ordered list.
  List<StyledTextContent> get toList {
    return [title, subtitle, text];
  }
}
