import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/single_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/answer/selection_list_tile.dart';

class SingleChoiceAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const SingleChoiceAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _SingleChoiceAnswerViewState createState() => _SingleChoiceAnswerViewState();
}

class _SingleChoiceAnswerViewState extends State<SingleChoiceAnswerView>
    with
        MeasureDateStateMixin,
        AnswerMixin<SingleChoiceAnswerView, TextChoice> {
  late final SingleChoiceAnswerFormat<TextChoice> _singleChoiceAnswerFormat;
  TextChoice? _selectedChoice;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('SingleSelectAnswer is null');
    }
    _singleChoiceAnswerFormat = answer as SingleChoiceAnswerFormat<TextChoice>;
    _selectedChoice =
        widget.result?.result as TextChoice? ??
        _singleChoiceAnswerFormat.defaultSelection;
    initValidation(_selectedChoice);
  }

  void _toggleChoice(TextChoice choice) {
    setState(() {
      _selectedChoice = _selectedChoice == choice ? null : choice;
    });
    onChange(_selectedChoice);
  }

  @override
  bool isValid(TextChoice? result) {
    if (widget.questionStep.isMandatory) {
      return result != null;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        const SizedBox(height: 12),
        for (final choice in _singleChoiceAnswerFormat.choices)
          SelectionListTile(
            text: choice.text,
            onTap: () => _toggleChoice(choice),
            isSelected: _selectedChoice == choice,
            isExclusive: true,
          ),
      ],
    );
  }
}
