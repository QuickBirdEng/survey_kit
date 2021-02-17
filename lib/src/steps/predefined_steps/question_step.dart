import 'package:flutter/widgets.dart';
import 'package:surveykit/src/answer_format/answer_format.dart';
import 'package:surveykit/src/answer_format/boolean_answer_format.dart';
import 'package:surveykit/src/answer_format/date_answer_format.dart';
import 'package:surveykit/src/answer_format/integer_answer_format.dart';
import 'package:surveykit/src/answer_format/multiple_choice_answer_format.dart';
import 'package:surveykit/src/answer_format/scale_answer_format.dart';
import 'package:surveykit/src/answer_format/single_choice_answer_format.dart';
import 'package:surveykit/src/answer_format/text_answer_format.dart';
import 'package:surveykit/src/answer_format/time_answer_formart.dart';
import 'package:surveykit/src/views/boolean_answer_view.dart';
import 'package:surveykit/src/views/date_answer_view.dart';
import 'package:surveykit/src/views/integer_answer_view.dart';
import 'package:surveykit/src/views/multiple_choice_answer_view.dart';
import 'package:surveykit/src/views/scale_answer_view.dart';
import 'package:surveykit/src/views/single_choice_answer_view.dart';
import 'package:surveykit/src/views/text_answer_view.dart';
import 'package:surveykit/src/result/question_result.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/steps/identifier/step_identifier.dart';
import 'package:surveykit/src/views/time_answer_view.dart';

class QuestionStep extends Step {
  final String title;
  final String text;
  final AnswerFormat answerFormat;

  QuestionStep({
    bool isOptional = false,
    String buttonText = 'Next',
    StepIdentifier id,
    this.title = '',
    this.text = '',
    @required this.answerFormat,
  }) : super(id: id, isOptional: isOptional, buttonText: buttonText);

  @override
  Widget createView({@required QuestionResult questionResult}) {
    switch (answerFormat.runtimeType) {
      case IntegerAnswerFormat:
        return IntegerAnswerView(
          questionStep: this,
          result: questionResult,
        );
      case TextAnswerFormat:
        return TextAnswerView(
          questionStep: this,
          result: questionResult,
        );
      case SingleChoiceAnswerFormat:
        return SingleChoiceAnswerView(
          questionStep: this,
          result: questionResult,
        );
      case MultipleChoiceAnswerFormat:
        return MultipleChoiceAnswerView(
          questionStep: this,
          result: questionResult,
        );
      case ScaleAnswerFormat:
        return ScaleAnswerView(
          questionStep: this,
          result: questionResult,
        );
      case BooleanAnswerFormat:
        return BooleanAnswerView(
          questionStep: this,
          result: questionResult,
        );
      case DateAnswerFormat:
        return DateAnswerView(
          questionStep: this,
          result: questionResult,
        );
      case TimeAnswerFormat:
        return TimeAnswerView(
          questionStep: this,
          result: questionResult,
        );
      default:
        throw AnswerFormatNotDefinedException();
    }
  }
}

class AnswerFormatNotDefinedException implements Exception {}
