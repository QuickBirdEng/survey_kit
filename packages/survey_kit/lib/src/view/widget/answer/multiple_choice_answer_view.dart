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
import 'package:survey_kit/src/view/widget/question_answer.dart';

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
  late final MultipleChoiceAnswerFormat _multipleChoiceAnswer;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('MultiSelectAnswer is null');
    }
    _multipleChoiceAnswer = answer as MultipleChoiceAnswerFormat;
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

    final _selectedChoices =
        QuestionAnswer.of(context).stepResult?.result as List<TextChoice>? ??
            widget.result?.result as List<TextChoice>? ??
            [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          const Divider(
            color: Colors.grey,
          ),
          ..._multipleChoiceAnswer.textChoices
              .map(
                (TextChoice tc) => SelectionListTile(
                  text: tc.text,
                  onTap: () {
                    setState(
                      () {
                        if (_selectedChoices.contains(tc)) {
                          _selectedChoices.remove(tc);
                        } else {}
                      },
                    );
                    onChange([..._selectedChoices, tc]);
                  },
                  isSelected: _selectedChoices.contains(tc),
                ),
              )
              .toList(),
          if (_multipleChoiceAnswer.otherField) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: ListTile(
                title: TextField(
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
                        _selectedChoices.remove(otherTextChoice);
                      } else if (v.isNotEmpty) {
                        final updatedTextChoice =
                            TextChoice(id: 'Other', value: v, text: v);
                        if (otherTextChoice == null) {
                          _selectedChoices.add(updatedTextChoice);
                        } else if (currentIndex != null) {
                          _selectedChoices[currentIndex!] = updatedTextChoice;
                        }
                      }
                      onChange(_selectedChoices);
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Other',
                    labelStyle: Theme.of(context).textTheme.headlineSmall,
                    hintText: 'Write other information here',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ],
      ),
    );
  }
}
