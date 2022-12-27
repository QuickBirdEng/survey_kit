import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/_new/model/answer/option.dart';
import 'package:survey_kit/src/_new/model/answer/single_select_answer.dart';
import 'package:survey_kit/src/_new/model/result/step_result.dart';
import 'package:survey_kit/src/_new/model/step.dart';
import 'package:survey_kit/src/_new/view/content/content_widget.dart';
import 'package:survey_kit/src/_new/view/selection_list_tile.dart';
import 'package:survey_kit/src/_new/view/step_view.dart';

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

class _SingleChoiceAnswerViewState extends State<SingleChoiceAnswerView> {
  late final DateTime _startDate;
  late final SingleSelectAnswer _singleChoiceAnswerFormat;
  Option? _selectedChoice;

  @override
  void initState() {
    super.initState();
    _singleChoiceAnswerFormat =
        widget.questionStep.answer as SingleSelectAnswer;
    _selectedChoice = widget.result?.result as Option? ??
        _singleChoiceAnswerFormat.defaultSelection;
    _startDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<Option>(
        id: widget.questionStep.id,
        startTime: _startDate,
        endTime: DateTime.now(),
        valueIdentifier: _selectedChoice?.value ?? '',
        result: _selectedChoice,
      ),
      isValid: !widget.questionStep.isMandatory || _selectedChoice != null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: ContentWidget(
                content: widget.questionStep.content,
              ),
            ),
            Column(
              children: [
                const Divider(
                  color: Colors.grey,
                ),
                ..._singleChoiceAnswerFormat.options.map(
                  (Option tc) {
                    return SelectionListTile(
                      text: tc.value,
                      onTap: () {
                        if (_selectedChoice == tc) {
                          _selectedChoice = null;
                        } else {
                          _selectedChoice = tc;
                        }
                        setState(() {});
                      },
                      isSelected: _selectedChoice == tc,
                    );
                  },
                ).toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
