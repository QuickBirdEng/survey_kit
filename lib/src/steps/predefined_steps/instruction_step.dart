import 'package:flutter/widgets.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/steps/identifier/step_identifier.dart';
import 'package:surveykit/src/views/instruction_view.dart';

class InstructionStep extends Step {
  final String title;
  final String text;

  InstructionStep({
    bool isOptional = false,
    String buttonText = 'Next',
    StepIdentifier id,
    @required this.title,
    @required this.text,
  }) : super(id: id, isOptional: isOptional, buttonText: buttonText);

  @override
  Widget createView({@required QuestionResult questionResult}) {
    return InstructionView(
      instructionStep: this,
    );
  }
}
