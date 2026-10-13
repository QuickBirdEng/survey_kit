import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/scale_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/question_answer.dart';

class ScaleAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const ScaleAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _ScaleAnswerViewState createState() => _ScaleAnswerViewState();
}

class _ScaleAnswerViewState extends State<ScaleAnswerView>
    with MeasureDateStateMixin, AnswerMixin<ScaleAnswerView, double> {
  late final ScaleAnswerFormat _scaleAnswerFormat;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('ScaleAnswerFormat is null');
    }
    _scaleAnswerFormat = answer as ScaleAnswerFormat;
    initValidation(
      (widget.result?.result as num?)?.toDouble() ??
          _scaleAnswerFormat.defaultValue,
    );
  }

  String _formatValue(double value) {
    final hasFractionalStep = _scaleAnswerFormat.step % 1 != 0;
    return hasFractionalStep ? value.toString() : value.round().toString();
  }

  @override
  Widget build(BuildContext context) {
    final result =
        QuestionAnswer.of(context).stepResult?.result as double? ??
        _scaleAnswerFormat.defaultValue;
    final questionText = _scaleAnswerFormat.question;
    final colorScheme = Theme.of(context).colorScheme;
    final formattedResult = _formatValue(result);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            child: Text(
              formattedResult,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),
          ),
          _ScaleDescriptions(
            minimumValueDescription: _scaleAnswerFormat.minimumValueDescription,
            maximumValueDescription: _scaleAnswerFormat.maximumValueDescription,
          ),
          Slider.adaptive(
            value: result,
            onChanged: onChange,
            min: _scaleAnswerFormat.minimumValue,
            max: _scaleAnswerFormat.maximumValue,
            activeColor: colorScheme.primary,
            divisions:
                (_scaleAnswerFormat.maximumValue -
                    _scaleAnswerFormat.minimumValue) ~/
                _scaleAnswerFormat.step,
            label: formattedResult,
          ),
        ],
      ),
    );
  }

  @override
  bool isValid(double? result) {
    return true;
  }
}

class _ScaleDescriptions extends StatelessWidget {
  const _ScaleDescriptions({
    required this.minimumValueDescription,
    required this.maximumValueDescription,
  });

  final String minimumValueDescription;
  final String maximumValueDescription;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(minimumValueDescription, style: style),
          Text(maximumValueDescription, style: style),
        ],
      ),
    );
  }
}
