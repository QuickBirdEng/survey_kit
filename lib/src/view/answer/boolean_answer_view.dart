import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/answer/selection_list_tile.dart';
import 'package:survey_kit/src/view/content/content_widget.dart';
import 'package:survey_kit/src/view/step_view.dart';

class BooleanAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult<BooleanResult>? result;

  const BooleanAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _BooleanAnswerViewState createState() => _BooleanAnswerViewState();
}

class _BooleanAnswerViewState extends State<BooleanAnswerView>
    with MeasureDateStateMixin {
  late final BooleanAnswerFormat _answerFormat;
  BooleanResult? _result;

  @override
  void initState() {
    super.initState();
    final answer = widget.questionStep.answerFormat;
    if (answer == null) {
      throw Exception('BooleanAnswerFormat is null');
    }
    _answerFormat = answer as BooleanAnswerFormat;

    _result = widget.result?.result ?? _answerFormat.result;
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      resultFunction: () => StepResult<BooleanResult>(
        id: widget.questionStep.id,
        startTime: startDate,
        endTime: DateTime.now(),
        valueIdentifier: _result == BooleanResult.positive
            ? _answerFormat.positiveAnswer
            : _result == BooleanResult.negative
                ? _answerFormat.negativeAnswer
                : '',
        result: _result,
      ),
      isValid: !widget.questionStep.isMandatory || _result != null,
      child: Column(
        children: [
          Column(
            children: [
              ContentWidget(
                content: widget.questionStep.content,
              ),
              const Divider(
                color: Colors.grey,
              ),
              SelectionListTile(
                text: _answerFormat.positiveAnswer,
                onTap: () {
                  if (_result == BooleanResult.positive) {
                    _result = null;
                  } else {
                    _result = BooleanResult.positive;
                  }
                  setState(() {});
                },
                isSelected: _result == BooleanResult.positive,
              ),
              SelectionListTile(
                text: _answerFormat.negativeAnswer,
                onTap: () {
                  if (_result == BooleanResult.negative) {
                    _result = null;
                  } else {
                    _result = BooleanResult.negative;
                  }
                  setState(() {});
                },
                isSelected: _result == BooleanResult.negative,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
