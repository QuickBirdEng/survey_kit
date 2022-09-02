import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/answer_format/agreement_answer_format.dart';
import 'package:survey_kit/src/result/question/agreement_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleCheckboxAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final SingleCheckboxQuestionResult? result;

  const SingleCheckboxAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _SingleCheckboxAnswerViewState createState() =>
      _SingleCheckboxAnswerViewState();
}

class _SingleCheckboxAnswerViewState extends State<SingleCheckboxAnswerView> {
  late final DateTime _startDate;
  late final SingleCheckboxAnswerFormat _singleCheckboxAnswerFormat;
  BooleanResult? _result;

  @override
  void initState() {
    super.initState();
    _singleCheckboxAnswerFormat =
        widget.questionStep.answerFormat as SingleCheckboxAnswerFormat;
    print(widget.result?.result);
    _result = widget.result?.result ??
        _singleCheckboxAnswerFormat.defaultValue ??
        BooleanResult.NEGATIVE;
    _startDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final markDownStyleSheet = MarkdownStyleSheet.fromTheme(theme);

    return StepView(
      step: widget.questionStep,
      resultFunction: () => SingleCheckboxQuestionResult(
        id: widget.questionStep.stepIdentifier,
        startDate: _startDate,
        endDate: DateTime.now(),
        valueIdentifier: _result != null ? _result.toString() : '',
        result: _result,
      ),
      isValid: widget.questionStep.isOptional ||
          (_result != null && _result == BooleanResult.POSITIVE),
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
                if (_singleCheckboxAnswerFormat.markdownDescription != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: MarkdownBody(
                      data: _singleCheckboxAnswerFormat.markdownDescription!,
                      styleSheet: markDownStyleSheet.copyWith(
                        textAlign: WrapAlignment.center,
                      ),
                      onTapLink: (text, href, title) =>
                          href != null ? launchUrl(Uri.parse(href)) : null,
                    ),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        groupValue: _result,
                        value: BooleanResult.POSITIVE,
                        onChanged: (v) {
                          setState(() {
                            _result = BooleanResult.POSITIVE;
                          });
                        }),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: MarkdownBody(
                      styleSheet: markDownStyleSheet.copyWith(
                        p: theme.textTheme.caption,
                      ),
                      data: _singleCheckboxAnswerFormat.markdownAgreementText ??
                          '',
                      onTapLink: (text, href, title) =>
                          href != null ? launchUrl(Uri.parse(href)) : null,
                    )),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
