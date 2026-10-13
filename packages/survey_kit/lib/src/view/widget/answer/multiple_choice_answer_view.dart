import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/multiple_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/answer/other_choice_field.dart';
import 'package:survey_kit/src/view/widget/answer/selection_list_tile.dart';

class MultipleChoiceAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const MultipleChoiceAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _MultipleChoiceAnswerView createState() => _MultipleChoiceAnswerView();
}

class _MultipleChoiceAnswerView extends State<MultipleChoiceAnswerView>
    with
        MeasureDateStateMixin,
        AnswerMixin<MultipleChoiceAnswerView, List<TextChoice>> {
  late final MultipleChoiceAnswerFormat<TextChoice> _multipleChoiceAnswer;
  List<TextChoice> _selectedChoices = [];

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('MultiSelectAnswer is null');
    }
    _multipleChoiceAnswer = answer as MultipleChoiceAnswerFormat<TextChoice>;
    final defaultSelection = _multipleChoiceAnswer.defaultSelection;
    _selectedChoices = List.of(
      widget.result?.result as List<TextChoice>? ?? [?defaultSelection],
    );
    initValidation(_selectedChoices);
  }

  @override
  bool isValid(List<TextChoice>? result) {
    if (widget.questionStep.isMandatory) {
      return result?.isNotEmpty ?? false;
    }
    return true;
  }

  void _toggleChoice(TextChoice choice) {
    setState(() {
      _selectedChoices = _selectedChoices.contains(choice)
          ? _selectedChoices.where((element) => element != choice).toList()
          : [..._selectedChoices, choice];
    });
    onChange(_selectedChoices);
  }

  void _onOtherTextChanged(String otherText) {
    setState(() {
      _selectedChoices = replaceOtherChoice(_selectedChoices, otherText);
    });
    onChange(_selectedChoices);
  }

  @override
  Widget build(BuildContext context) {
    final questionText = _multipleChoiceAnswer.question;

    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        const SizedBox(height: 12),
        for (final choice in _multipleChoiceAnswer.choices)
          SelectionListTile(
            text: choice.text,
            onTap: () => _toggleChoice(choice),
            isSelected: _selectedChoices.contains(choice),
          ),
        if (_multipleChoiceAnswer.otherField)
          OtherChoiceField(
            initialValue: findOtherChoiceText(_selectedChoices),
            onChanged: _onOtherTextChanged,
          ),
      ],
    );
  }
}
