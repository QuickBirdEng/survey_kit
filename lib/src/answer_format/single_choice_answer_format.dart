import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';
import 'package:survey_kit/src/answer_format/text_choice.dart';

class SingleChoiceAnswerFormat implements AnswerFormat {
  final List<TextChoice> textChoices;
  final TextChoice defaultSelection;

  SingleChoiceAnswerFormat({
    @required this.textChoices,
    this.defaultSelection,
  });
}
