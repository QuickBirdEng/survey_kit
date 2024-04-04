import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import '../survey_kit.dart';
import 'answer/answer_format.dart';
import 'content/content.dart';

part 'step.g.dart';

@JsonSerializable()
class Step {
  final String id;
  final bool isMandatory;
  final AnswerFormat? answerFormat;
  @JsonKey(defaultValue: 'Next', includeIfNull: false)
  final String? buttonText;
  final List<Content> content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StepShell? stepShell;

  Step({
    String? id,
    required this.content,
    this.isMandatory = true,
    this.answerFormat,
    this.buttonText,
    this.stepShell,
  }) : id = id ?? const Uuid().v4();

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}
