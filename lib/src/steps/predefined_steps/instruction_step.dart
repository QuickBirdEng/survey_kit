import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/views/instruction_view.dart';

part 'instruction_step.g.dart';

@JsonSerializable()
class InstructionStep extends Step {
  final String title;
  final String text;

  InstructionStep({
    bool isOptional = false,
    String buttonText = 'Next',
    StepIdentifier? id,
    required this.title,
    required this.text,
  }) : super(id: id, isOptional: isOptional, buttonText: buttonText);

  @override
  Widget createView({required QuestionResult? questionResult}) {
    return InstructionView(
      instructionStep: this,
    );
  }

  factory InstructionStep.fromJson(Map<String, dynamic> json) =>
      _$InstructionStepFromJson(json);
  Map<String, dynamic> toJson() => _$InstructionStepToJson(this);
}
