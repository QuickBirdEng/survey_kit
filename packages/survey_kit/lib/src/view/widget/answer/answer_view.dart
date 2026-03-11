import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/configuration/survey_kit_registry.dart';
import 'package:survey_kit/src/view/step_view.dart';
import 'package:survey_kit/survey_kit.dart';

class AnswerView extends StatefulWidget {
  const AnswerView({
    super.key,
    required this.answer,
    required this.step,
    required this.stepResult,
  });
  final AnswerFormat? answer;

  final Step step;
  final StepResult? stepResult;

  @override
  State<AnswerView> createState() => _AnswerViewState();
}

class _AnswerViewState extends State<AnswerView> {
  late bool _isValid;
  StepResult? _stepResult;
  late DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _isValid = !widget.step.isMandatory || widget.step.answerFormat == null;
    _startTime = DateTime.now();
    _stepResult = widget.stepResult;
  }

  void _onValidityChanged(bool isValid) {
    setState(() => _isValid = isValid);
  }

  void _onResultChanged(dynamic result) {
    setState(() {
      _stepResult = StepResult(
        id: widget.step.id,
        step: widget.step,
        result: result,
        startTime: _startTime,
        endTime: DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget? answerView;
    final registry = SurveyKitRegistry.of(context);
    if (widget.answer != null) {
      answerView = registry?.createAnswerView(
        widget.answer!,
        widget.step,
        widget.stepResult,
      );
      answerView ??= Center(
        child: Text(
          'No view for ${widget.answer.runtimeType}',
        ),
      );
    }
    final stepShell =
        widget.step.stepShell ?? SurveyStateProvider.of(context).stepShell;

    return QuestionAnswer(
      step: widget.step,
      isValid: _isValid,
      stepResult: _stepResult,
      onValidityChanged: _onValidityChanged,
      onResultChanged: _onResultChanged,
      child: Builder(
        builder: (context) => stepShell != null
            ? stepShell.call(
                widget.step,
                answerView,
                context,
              )
            : StepView(
                step: widget.step,
                answerView: answerView,
              ),
      ),
    );
  }
}
