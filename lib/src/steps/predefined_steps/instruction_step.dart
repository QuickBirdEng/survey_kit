import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/views/instruction_view.dart';

part 'instruction_step.g.dart';

@JsonSerializable(explicitToJson: true)
class InstructionStep extends Step {
  final String title;
  final String text;

  InstructionStep({
    required this.title,
    required this.text,
    super.isOptional,
    String super.buttonText,
    super.stepIdentifier,
    bool? canGoBack,
    bool? showProgress,
    super.showAppBar,
  }) : super(
          canGoBack: canGoBack ?? false,
          showProgress: showProgress ?? false,
        );

  @override
  Widget createView({required QuestionResult? questionResult}) {
    return InstructionView(
      instructionStep: this,
    );
  }

  factory InstructionStep.fromJson(Map<String, dynamic> json) =>
      _$InstructionStepFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$InstructionStepToJson(this);

  @override
  bool operator ==(other) =>
      super == (other) &&
      other is InstructionStep &&
      other.title == title &&
      other.text == text;
  @override
  int get hashCode => super.hashCode ^ title.hashCode ^ text.hashCode;
}
