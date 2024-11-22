import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/views/completion_view.dart';

part 'completion_step.g.dart';

@JsonSerializable()
class CompletionStep extends Step {
  final String title;
  final String text;
  final String assetPath;

  CompletionStep(
      {super.isOptional,
      required StepIdentifier super.stepIdentifier,
      String super.buttonText = 'End Survey',
      super.showAppBar,
      required this.title,
      required this.text,
      this.assetPath = ""});

  @override
  Widget createView({required QuestionResult? questionResult}) {
    return CompletionView(completionStep: this, assetPath: assetPath);
  }

  factory CompletionStep.fromJson(Map<String, dynamic> json) =>
      _$CompletionStepFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$CompletionStepToJson(this);

  @override
  bool operator ==(other) =>
      super == (other) &&
      other is CompletionStep &&
      other.title == title &&
      other.text == text;
  @override
  int get hashCode => super.hashCode ^ title.hashCode ^ text.hashCode;
}
