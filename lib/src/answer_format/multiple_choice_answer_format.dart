import 'package:flutter/widgets.dart';
import 'package:surveykit/src/answer_format/answer_format.dart';
import 'package:surveykit/src/answer_format/text_choice.dart';

class MultipleChoiceAnswerFormat implements AnswerFormat {
  final List<TextChoice> textChoices;
  final List<TextChoice> defaultSelection;

  MultipleChoiceAnswerFormat({
    @required this.textChoices,
    this.defaultSelection = const [],
  });
}
