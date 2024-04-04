import 'package:flutter/material.dart' hide Step;

import '../../../model/answer/single_choice_answer_format.dart';
import '../../../model/answer/text_choice.dart';
import '../../../model/result/step_result.dart';
import '../../../model/step.dart';
import '../../../util/measure_date_state_mixin.dart';
import 'answer_mixin.dart';
import 'answer_question_text.dart';
import 'selection_list_tile.dart';

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
  late final SingleChoiceAnswerFormat _singleChoiceAnswerFormat;
  TextChoice? _selectedChoice;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('SingleSelectAnswer is null');
    }
    _singleChoiceAnswerFormat = answer as SingleChoiceAnswerFormat;
    _selectedChoice = widget.result?.result as TextChoice? ??
        _singleChoiceAnswerFormat.defaultSelection;
  }

  @override
  void onChange(TextChoice? choice) {
    if (_selectedChoice == choice) {
      _selectedChoice = null;
    } else {
      _selectedChoice = choice;
    }
    setState(() {});
    super.onChange(choice);
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          const Divider(
            color: Colors.grey,
          ),
          ..._singleChoiceAnswerFormat.textChoices.map(
            (TextChoice tc) {
              return SelectionListTile(
                text: tc.text,
                onTap: () {
                  onChange(tc);
                },
                isSelected: _selectedChoice == tc,
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
