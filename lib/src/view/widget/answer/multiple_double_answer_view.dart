import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/src/model/answer/multiple_double_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/step_view.dart';
import 'package:survey_kit/src/view/widget/content/content_widget.dart';

class MultipleDoubleAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const MultipleDoubleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  State<MultipleDoubleAnswerView> createState() =>
      _MultipleDoubleAnswerViewState();
}

class _MultipleDoubleAnswerViewState extends State<MultipleDoubleAnswerView>
    with MeasureDateStateMixin {
  late final MultipleDoubleAnswerFormat _multipleDoubleAnswer;
  late final List<TextEditingController> _controller;

  bool _isValid = false;
  List<MultiDouble> _insertedValues = [];

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('MultipleDoubleAnswerFormat is null');
    }
    _multipleDoubleAnswer = answer as MultipleDoubleAnswerFormat;
    _controller = _multipleDoubleAnswer.hints.map((e) {
      return TextEditingController();
    }).toList();

    for (var element in _controller) {
      element = TextEditingController()
        ..text = widget.result?.result?.toString() ?? '';
      _checkValidation(element.text);
    }

    _insertedValues = List.generate(
      _multipleDoubleAnswer.hints.length,
      (index) => const MultiDouble(
        text: '',
        value: 0.0,
      ),
    );
  }

  @override
  void dispose() {
    for (final element in _controller) {
      element.dispose();
    }
    super.dispose();
  }

  void _checkValidation(String text) {
    setState(() {
      _isValid = text.isNotEmpty && double.tryParse(text) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<List<MultiDouble>>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _controller.map((e) => e.text).join(', '),
        result: _insertedValues,
      ),
      isValid: _isValid || !widget.questionStep.isMandatory,
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
                ..._multipleDoubleAnswer.hints
                    .asMap()
                    .entries
                    .map((MapEntry<int, String> md) {
                  return TextField(
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: md.value,
                    ),
                    controller: _controller[md.key],
                    onChanged: (String value) {
                      value = value.replaceAll(',', '.');

                      _checkValidation(value);

                      _insertedValues[md.key] = MultiDouble(
                        text: md.value,
                        value: double.parse(value),
                      );
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  );
                }).toList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
