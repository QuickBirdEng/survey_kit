import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/views/completion_view.dart';

part 'completion_step.g.dart';

@JsonSerializable()
class CompletionStep extends Step {
  final String title;
  final String text;

  CompletionStep({
    bool isOptional = false,
    required StepIdentifier stepIdentifier,
    String buttonText = 'End Survey',
    required this.title,
    required this.text,
  }) : super(
            stepIdentifier: stepIdentifier,
            isOptional: isOptional,
            buttonText: buttonText);

  @override
  Widget createView({required QuestionResult? questionResult}) {
    return CompletionView(completionStep: this);
  }

  factory CompletionStep.fromJson(Map<String, dynamic> json) =>
      _$CompletionStepFromJson(json);
  Map<String, dynamic> toJson() => _$CompletionStepToJson(this);
}
