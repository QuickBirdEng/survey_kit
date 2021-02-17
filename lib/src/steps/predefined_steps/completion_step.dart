import 'package:flutter/widgets.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/steps/identifier/step_identifier.dart';
import 'package:surveykit/src/views/completion_view.dart';

class CompletionStep extends Step {
  final String title;
  final String text;

  CompletionStep({
    bool isOptional = false,
    @required StepIdentifier id,
    String buttonText = 'End Survey',
    @required this.title,
    @required this.text,
  }) : super(id: id, isOptional: isOptional, buttonText: buttonText);

  @override
  Widget createView({@required QuestionResult questionResult}) {
    return CompletionView(completionStep: this);
  }
}
