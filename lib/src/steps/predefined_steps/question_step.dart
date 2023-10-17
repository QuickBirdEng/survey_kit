import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';
import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/answer_format/date_answer_format.dart';
import 'package:survey_kit/src/answer_format/double_answer_format.dart';
import 'package:survey_kit/src/answer_format/image_answer_format.dart';
import 'package:survey_kit/src/answer_format/integer_answer_format.dart';
import 'package:survey_kit/src/answer_format/multiple_choice_answer_format.dart';
import 'package:survey_kit/src/answer_format/multiple_choice_auto_complete_answer_format.dart';
import 'package:survey_kit/src/answer_format/multiple_double_answer_format.dart';
import 'package:survey_kit/src/answer_format/scale_answer_format.dart';
import 'package:survey_kit/src/answer_format/single_choice_answer_format.dart';
import 'package:survey_kit/src/answer_format/text_answer_format.dart';
import 'package:survey_kit/src/answer_format/time_answer_formart.dart';
import 'package:survey_kit/src/result/question/boolean_question_result.dart';
import 'package:survey_kit/src/result/question/date_question_result.dart';
import 'package:survey_kit/src/result/question/double_question_result.dart';
import 'package:survey_kit/src/result/question/image_question_result.dart';
import 'package:survey_kit/src/result/question/integer_question_result.dart';
import 'package:survey_kit/src/result/question/multiple_choice_question_result.dart';
import 'package:survey_kit/src/result/question/multiple_double_question_result.dart';
import 'package:survey_kit/src/result/question/scale_question_result.dart';
import 'package:survey_kit/src/result/question/single_choice_question_result.dart';
import 'package:survey_kit/src/result/question/text_question_result.dart';
import 'package:survey_kit/src/result/question/time_question_result.dart';
import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/step_identifier.dart';
import 'package:survey_kit/src/steps/predefined_steps/answer_format_not_defined_exception.dart';
import 'package:survey_kit/src/steps/step.dart';
import 'package:survey_kit/src/views/boolean_answer_view.dart';
import 'package:survey_kit/src/views/date_answer_view.dart';
import 'package:survey_kit/src/views/double_answer_view.dart';
import 'package:survey_kit/src/views/multiple_auto_complete_answer_view.dart';
import 'package:survey_kit/src/views/image_answer_view.dart';
import 'package:survey_kit/src/views/integer_answer_view.dart';
import 'package:survey_kit/src/views/multiple_choice_answer_view.dart';
import 'package:survey_kit/src/views/multiple_double_answer_view.dart';
import 'package:survey_kit/src/views/scale_answer_view.dart';
import 'package:survey_kit/src/views/single_choice_answer_view.dart';
import 'package:survey_kit/src/views/text_answer_view.dart';
import 'package:survey_kit/src/views/time_answer_view.dart';

part 'question_step.g.dart';

@JsonSerializable()
class QuestionStep extends Step {
  @JsonKey(defaultValue: '')
  final String title;
  @JsonKey(defaultValue: '')
  final String text;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Widget content;
  final AnswerFormat answerFormat;

  QuestionStep({
    bool isOptional = false,
    String buttonText = 'Next',
    StepIdentifier? stepIdentifier,
    bool showAppBar = true,
    this.title = '',
    this.text = '',
    this.content = const SizedBox.shrink(),
    required this.answerFormat,
  }) : super(
          stepIdentifier: stepIdentifier,
          isOptional: isOptional,
          buttonText: buttonText,
          showAppBar: showAppBar,
        );

  @override
  Widget createView({required QuestionResult? questionResult}) {
    final key = ObjectKey(this.stepIdentifier.id);

    switch (answerFormat.runtimeType) {
      case IntegerAnswerFormat:
        return IntegerAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as IntegerQuestionResult?,
        );
      case DoubleAnswerFormat:
        return DoubleAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as DoubleQuestionResult?,
        );
      case TextAnswerFormat:
        return TextAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as TextQuestionResult?,
        );
      case SingleChoiceAnswerFormat:
        FocusManager.instance.primaryFocus?.unfocus();
        return SingleChoiceAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as SingleChoiceQuestionResult?,
        );
      case MultipleChoiceAnswerFormat:
        return MultipleChoiceAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as MultipleChoiceQuestionResult?,
        );
      case ScaleAnswerFormat:
        return ScaleAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as ScaleQuestionResult?,
        );
      case BooleanAnswerFormat:
        return BooleanAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as BooleanQuestionResult?,
        );
      case DateAnswerFormat:
        return DateAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as DateQuestionResult?,
        );
      case TimeAnswerFormat:
        return TimeAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as TimeQuestionResult?,
        );
      case MultipleDoubleAnswerFormat:
        return MultipleDoubleAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as MultipleDoubleQuestionResult?,
        );
      case MultipleChoiceAutoCompleteAnswerFormat:
        return MultipleChoiceAutoCompleteAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as MultipleChoiceQuestionResult?,
        );
      case ImageAnswerFormat:
        return ImageAnswerView(
          key: key,
          questionStep: this,
          result: questionResult as ImageQuestionResult?,
        );
      default:
        throw AnswerFormatNotDefinedException();
    }
  }

  factory QuestionStep.fromJson(Map<String, dynamic> json) =>
      _$QuestionStepFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionStepToJson(this);
}
