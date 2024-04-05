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
  }

  @override
  Widget build(BuildContext context) {
    final result = QuestionAnswer.of(context).stepResult?.result as double? ??
        _scaleAnswerFormat.defaultValue;
    final questionText = widget.questionStep.answerFormat?.question;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              result.toInt().toString(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _scaleAnswerFormat.minimumValueDescription,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      _scaleAnswerFormat.maximumValueDescription,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Slider.adaptive(
                value: result,
                onChanged: (double value) {
                  setState(() {
                    onChange(value);
                  });
                },
                min: _scaleAnswerFormat.minimumValue,
                max: _scaleAnswerFormat.maximumValue,
                activeColor: Theme.of(context).primaryColor,
                divisions: (_scaleAnswerFormat.maximumValue -
                        _scaleAnswerFormat.minimumValue) ~/
                    _scaleAnswerFormat.step,
                label: result.toString(),
              ),
            ],
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
