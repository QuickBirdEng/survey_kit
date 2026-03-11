import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/multiple_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
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
    _selectedChoices = widget.result?.result as List<TextChoice>? ??
        (defaultSelection != null ? [defaultSelection] : []);
  }

  @override
  bool isValid(List<TextChoice>? result) {
    if (widget.questionStep.isMandatory) {
      return result?.isNotEmpty ?? false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;

    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          const SizedBox(height: 12),
          ..._multipleChoiceAnswer.choices
              .map(
                (TextChoice tc) => SelectionListTile(
                  text: tc.text,
                  onTap: () {
                    setState(
                      () {
                        if (_selectedChoices.contains(tc)) {
                          _selectedChoices = _selectedChoices
                              .where((element) => element != tc)
                              .toList();
                        } else {
                          _selectedChoices = [..._selectedChoices, tc];
                        }
                      },
                    );
                    onChange(_selectedChoices);
                  },
                  isSelected: _selectedChoices.contains(tc),
                ),
              )
              .toList(),
          if (_multipleChoiceAnswer.otherField) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextField(
                onChanged: (v) {
                  int? currentIndex;
                  final otherTextChoice = _selectedChoices
                      .firstWhereIndexedOrNull((index, element) {
                    final isOtherField = element.value == 'Other';

                    if (isOtherField) {
                      currentIndex = index;
                    }

                    return isOtherField;
                  });

                  setState(() {
                    if (v.isEmpty && otherTextChoice != null) {
                      _selectedChoices = _selectedChoices
                          .where((element) => element != otherTextChoice)
                          .toList();
                    } else if (v.isNotEmpty) {
                      final updatedTextChoice =
                          TextChoice(id: 'Other', value: v, text: v);
                      if (otherTextChoice == null) {
                        _selectedChoices = [
                          ..._selectedChoices,
                          updatedTextChoice,
                        ];
                      } else if (currentIndex != null) {
                        _selectedChoices = List.from(_selectedChoices);
                        _selectedChoices[currentIndex!] = updatedTextChoice;
                      }
                    }
                    onChange(_selectedChoices);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Other',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                  hintText: 'Write other information here',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 16.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide:
                        BorderSide(color: Colors.grey.shade300, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
