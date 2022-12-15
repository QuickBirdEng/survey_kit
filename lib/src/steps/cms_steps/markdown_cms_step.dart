import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/steps/cms_steps/cms_content_step.dart';
import 'package:survey_kit/src/widget/survey_kit_markdown.dart';

part 'markdown_cms_step.g.dart';

@JsonSerializable(explicitToJson: true)
class MarkdownCMSStep extends Content {
  final String markdown;

  MarkdownCMSStep({
    required this.markdown,
  });

  @override
  Widget createView() {
    return SurveyKitMarkdown(
      markdown: markdown,
    );
  }

  factory MarkdownCMSStep.fromJson(Map<String, dynamic> json) =>
      _$MarkdownCMSStepFromJson(json);
  Map<String, dynamic> toJson() => _$MarkdownCMSStepToJson(this);
}
