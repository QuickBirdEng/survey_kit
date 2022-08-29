import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:survey_kit/src/answer_format/multiple_choice_auto_complete_answer_format.dart';
import 'package:survey_kit/survey_kit.dart';

class MultipleChoiceAutoCompleteAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final MultipleChoiceQuestionResult? result;
  const MultipleChoiceAutoCompleteAnswerView({
    Key? key,
    required this.questionStep,
    this.result,
  }) : super(key: key);

  @override
  State<MultipleChoiceAutoCompleteAnswerView> createState() =>
      _MultipleChoiceAutoCompleteAnswerViewState();
}

class _MultipleChoiceAutoCompleteAnswerViewState
    extends State<MultipleChoiceAutoCompleteAnswerView> {
  late final DateTime _startDateTime;
  late final MultipleChoiceAutoCompleteAnswerFormat _multipleChoiceAnswer;

  List<TextChoice> _selectedChoices = [];

  @override
  void initState() {
    super.initState();
    _multipleChoiceAnswer = widget.questionStep.answerFormat
        as MultipleChoiceAutoCompleteAnswerFormat;
    _selectedChoices =
        widget.result?.result ?? _multipleChoiceAnswer.defaultSelection;
    _startDateTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => MultipleChoiceQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDateTime,
        endDate: DateTime.now(),
        valueIdentifier:
            _selectedChoices.map((choices) => choices.value).join(','),
        result: _selectedChoices,
      ),
      isValid: widget.questionStep.isOptional || _selectedChoices.isNotEmpty,
      title: widget.questionStep.title.isNotEmpty
          ? Text(
              widget.questionStep.title,
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            )
          : widget.questionStep.content,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                widget.questionStep.text,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                Autocomplete<TextChoice>(
                  fieldViewBuilder: (context, textEditingController, focusNode,
                          onFieldSubmitted) =>
                      TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration:
                        InputDecoration(labelText: 'Search more medicines...'),
                    onSubmitted: (v) {
                      onFieldSubmitted();
                    },
                  ),
                  optionsViewBuilder: (context, onSelected, options) => Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final option = options.elementAt(index);
                            return InkWell(
                              onTap: () {
                                onSelected(option);
                              },
                              child: Builder(builder: (BuildContext context) {
                                final bool highlight =
                                    AutocompleteHighlightedOption.of(context) ==
                                        index;
                                if (highlight) {
                                  SchedulerBinding.instance
                                      .addPostFrameCallback(
                                          (Duration timeStamp) {
                                    Scrollable.ensureVisible(context,
                                        alignment: 0.5);
                                  });
                                }
                                return Container(
                                  color: highlight
                                      ? Theme.of(context).focusColor
                                      : null,
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(option.text),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  displayStringForOption: (tc) => tc.text,
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<TextChoice>.empty();
                    }

                    return _multipleChoiceAnswer.suggestions.where((element) =>
                        element.text
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()));
                  },
                  onSelected: (tc) {
                    setState(
                      () {
                        if (_selectedChoices.contains(tc)) {
                          _selectedChoices.remove(tc);
                        } else {
                          _selectedChoices = [..._selectedChoices, tc];
                        }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                Divider(
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
                              } else {
                                _selectedChoices = [..._selectedChoices, tc];
                              }
                            },
                          );
                        },
                        isSelected: _selectedChoices.contains(tc),
                      ),
                    )
                    .toList(),
                ..._selectedChoices
                    .where((element) =>
                        !_multipleChoiceAnswer.textChoices.contains(element))
                    .map(
                      (TextChoice tc) => SelectionListTile(
                        text: tc.text,
                        onTap: () {
                          setState(
                            () {
                              if (_selectedChoices.contains(tc)) {
                                _selectedChoices.remove(tc);
                              } else {
                                _selectedChoices = [..._selectedChoices, tc];
                              }
                            },
                          );
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
                            final isOtherField = element.text == 'Other';

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
                                  TextChoice(text: 'Other', value: v);
                              if (otherTextChoice == null) {
                                _selectedChoices.add(updatedTextChoice);
                              } else if (currentIndex != null) {
                                _selectedChoices[currentIndex!] =
                                    updatedTextChoice;
                              }
                            }
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Other',
                          labelStyle: Theme.of(context).textTheme.headline5,
                          hintText: 'Write other information here',
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
