import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';
import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/answer_format/date_answer_format.dart';
import 'package:survey_kit/src/answer_format/integer_answer_format.dart';
import 'package:survey_kit/src/answer_format/multiple_choice_answer_format.dart';
import 'package:survey_kit/src/answer_format/scale_answer_format.dart';
import 'package:survey_kit/src/answer_format/single_choice_answer_format.dart';
import 'package:survey_kit/src/answer_format/text_answer_format.dart';
import 'package:survey_kit/src/answer_format/time_answer_formart.dart';
import 'package:survey_kit/src/result/question/boolean_question_result.dart';
import 'package:survey_kit/src/result/question/date_question_result.dart';
import 'package:survey_kit/src/result/question/integer_question_result.dart';
import 'package:survey_kit/src/result/question/multiple_choice_question_result.dart';
import 'package:survey_kit/src/result/question/scale_question_result.dart';
import 'package:survey_kit/src/result/question/single_choice_question_result.dart';
import 'package:survey_kit/src/result/question/text_question_result.dart';
import 'package:survey_kit/src/result/question/time_question_result.dart';
import 'package:survey_kit/src/views/boolean_answer_view.dart';
import 'package:survey_kit/src/views/date_answer_view.dart';
import 'package:survey_kit/src/views/integer_answer_view.dart';
import 'package:survey_kit/src/views/multiple_choice_answer_view.dart';
import 'package:survey_kit/src/views/scale_answer_view.dart';
import 'package:survey_kit/src/views/single_choice_answer_view.dart';
import 'package:survey_kit/src/views/text_answer_view.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/views/time_answer_view.dart';

class QuestionStep extends Step {
  final String title;
  final String text;
  final AnswerFormat answerFormat;

  QuestionStep({
    bool isOptional = false,
    String buttonText = 'Next',
    StepIdentifier? id,
    this.title = '',
    this.text = '',
    required this.answerFormat,
  }) : super(id: id, isOptional: isOptional, buttonText: buttonText);

  @override
  Widget createView({required QuestionResult? questionResult}) {
    switch (answerFormat.runtimeType) {
      case IntegerAnswerFormat:
        return IntegerAnswerView(
          questionStep: this,
          result: questionResult as IntegerQuestionResult?,
        );
      case TextAnswerFormat:
        return TextAnswerView(
          questionStep: this,
          result: questionResult as TextQuestionResult?,
        );
      case SingleChoiceAnswerFormat:
        return SingleChoiceAnswerView(
          questionStep: this,
          result: questionResult as SingleChoiceQuestionResult?,
        );
      case MultipleChoiceAnswerFormat:
        return MultipleChoiceAnswerView(
          questionStep: this,
          result: questionResult as MultipleChoiceQuestionResult?,
        );
      case ScaleAnswerFormat:
        return ScaleAnswerView(
          questionStep: this,
          result: questionResult as ScaleQuestionResult?,
        );
      case BooleanAnswerFormat:
        return BooleanAnswerView(
          questionStep: this,
          result: questionResult as BooleanQuestionResult?,
        );
      case DateAnswerFormat:
        return DateAnswerView(
          questionStep: this,
          result: questionResult as DateQuestionResult?,
        );
      case TimeAnswerFormat:
        return TimeAnswerView(
          questionStep: this,
          result: questionResult as TimeQuestionResult?,
        );
      default:
        throw AnswerFormatNotDefinedException();
    }
  }
}

class AnswerFormatNotDefinedException implements Exception {}
