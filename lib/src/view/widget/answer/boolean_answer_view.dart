import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/util/measure_date_state_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_mixin.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/answer/selection_list_tile.dart';

class BooleanAnswerView extends StatefulWidget {
  final Step questionStep;
  final StepResult? result;

  const BooleanAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _BooleanAnswerViewState createState() => _BooleanAnswerViewState();
}

class _BooleanAnswerViewState extends State<BooleanAnswerView>
    with
        MeasureDateStateMixin<BooleanAnswerView>,
        AnswerMixin<BooleanAnswerView, BooleanResult> {
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
    _result = widget.result?.result as BooleanResult? ?? _answerFormat.result;
  }

  @override
  bool isValid(dynamic result) {
    if (widget.questionStep.isMandatory) {
      return _result != null;
    }
    return true;
  }

  @override
  void onChange(BooleanResult? booleanResult) {
    if (booleanResult == _result) {
      _result = null;
    } else {
      _result = booleanResult;
    }
    setState(() {});
    super.onChange(_result);
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.questionStep.answerFormat?.question;
    return Column(
      children: [
        if (questionText != null) AnswerQuestionText(text: questionText),
        const Divider(
          color: Colors.grey,
        ),
        SelectionListTile(
          text: _answerFormat.positiveAnswer,
          onTap: () => onChange(BooleanResult.positive),
          isSelected: _result == BooleanResult.positive,
        ),
        SelectionListTile(
          text: _answerFormat.negativeAnswer,
          onTap: () => onChange(BooleanResult.negative),
          isSelected: _result == BooleanResult.negative,
        ),
      ],
    );
  }
}
