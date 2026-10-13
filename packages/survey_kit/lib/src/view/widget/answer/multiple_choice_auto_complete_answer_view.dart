import 'package:flutter/material.dart' hide Step;
import 'package:flutter/scheduler.dart';
import 'package:survey_kit/gen/survey_kit_localizations.dart';
import 'package:survey_kit/src/model/answer/multiple_choice_auto_complete_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/answer/other_choice_field.dart';
import 'package:survey_kit/src/view/widget/answer/selection_list_tile.dart';

class MultipleChoiceAutoCompleteAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;
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
    extends State<MultipleChoiceAutoCompleteAnswerView>
    with
        MeasureDateStateMixin,
        AnswerMixin<MultipleChoiceAutoCompleteAnswerView, List<TextChoice>> {
  late final MultipleChoiceAutoCompleteAnswerFormat _multipleChoiceAnswer;

  List<TextChoice> _selectedChoices = [];

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('MultipleChoiceAutoCompleteAnswerFormat is null');
    }
    _multipleChoiceAnswer = answer as MultipleChoiceAutoCompleteAnswerFormat;
    _selectedChoices = List.of(
      widget.result?.result as List<TextChoice>? ??
          _multipleChoiceAnswer.defaultSelection,
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
    final additionalChoices = _selectedChoices.where(
      (choice) =>
          choice.id != otherChoiceId &&
          !_multipleChoiceAnswer.choices.contains(choice),
    );

    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        _AutoComplete(
          suggestions: _multipleChoiceAnswer.suggestions,
          onSelected: _toggleChoice,
          selectedChoices: _selectedChoices,
        ),
        const SizedBox(height: 44),
        for (final choice in [
          ..._multipleChoiceAnswer.choices,
          ...additionalChoices,
        ])
          SelectionListTile(
            text: choice.text,
            onTap: () => _toggleChoice(choice),
            isSelected: _selectedChoices.contains(choice),
          ),
        if (_multipleChoiceAnswer.otherField)
          OtherChoiceField(
            initialValue: findOtherChoiceText(_selectedChoices),
            onChanged: _onOtherTextChanged,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 4.0,
            ),
          ),
      ],
    );
  }
}

class _AutoComplete extends StatelessWidget {
  const _AutoComplete({
    Key? key,
    required this.suggestions,
    required this.onSelected,
    required this.selectedChoices,
  }) : super(key: key);

  final List<TextChoice> suggestions;
  final void Function(TextChoice) onSelected;
  final List<TextChoice> selectedChoices;

  @override
  Widget build(BuildContext context) {
    final localizations = SurveyKitLocalizations.of(context);

    return Autocomplete<TextChoice>(
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) =>
              TextField(
                controller: textEditingController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 32),
                  labelText: localizations?.searchLabel ?? 'Search',
                  hintText: localizations?.searchHint ?? 'Type here to search',
                  suffixIcon: IconButton(
                    tooltip: localizations?.clearSearch ?? 'Clear search',
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  ),
                ),
                onSubmitted: (v) {
                  onFieldSubmitted();
                },
              ),
      optionsViewBuilder: (context, onSelected, options) => _OptionsViewBuilder(
        options: options,
        onSelected: onSelected,
        selectedChoices: selectedChoices,
      ),
      displayStringForOption: (tc) => tc.text,
      optionsBuilder: (textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<TextChoice>.empty();
        }

        return suggestions.where(
          (element) => element.text.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },
      onSelected: onSelected,
    );
  }
}

class _OptionsViewBuilder extends StatelessWidget {
  const _OptionsViewBuilder({
    Key? key,
    required this.options,
    required this.onSelected,
    required this.selectedChoices,
  }) : super(key: key);

  final Iterable<TextChoice> options;
  final void Function(TextChoice) onSelected;
  final List<TextChoice> selectedChoices;
  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.topLeft,
    child: Material(
      elevation: 4.0,
      textStyle: Theme.of(context).textTheme.bodyLarge,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
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
              child: Builder(
                builder: (BuildContext context) {
                  final highlight =
                      AutocompleteHighlightedOption.of(context) == index;
                  if (highlight) {
                    SchedulerBinding.instance.addPostFrameCallback((
                      Duration timeStamp,
                    ) {
                      Scrollable.ensureVisible(context, alignment: 0.5);
                    });
                  }
                  return Container(
                    color: highlight ? Theme.of(context).focusColor : null,
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(option.text),
                        if (selectedChoices.contains(option))
                          const Icon(Icons.done),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    ),
  );
}
