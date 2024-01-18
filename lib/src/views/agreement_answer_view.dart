import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:survey_kit/src/answer_format/boolean_answer_format.dart';
import 'package:survey_kit/src/answer_format/agreement_answer_format.dart';
import 'package:survey_kit/src/result/question/agreement_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreementAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final AgreementQuestionResult? result;

  const AgreementAnswerView({
    Key? key,
    required this.questionStep,
    required this.result,
  }) : super(key: key);

  @override
  _AgreementAnswerViewState createState() => _AgreementAnswerViewState();
}

class _AgreementAnswerViewState extends State<AgreementAnswerView> {
  late final DateTime _startDate;
  late final AgreementAnswerFormat _agreementAnswerFormat;
  BooleanResult? _result;

  @override
  void initState() {
    super.initState();
    _agreementAnswerFormat =
        widget.questionStep.answerFormat as AgreementAnswerFormat;
    _result = widget.result?.result ??
        _agreementAnswerFormat.defaultValue ??
        BooleanResult.NEGATIVE;
    _startDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final markDownStyleSheet = MarkdownStyleSheet.fromTheme(theme);

    return StepView(
      step: widget.questionStep,
      resultFunction: () => AgreementQuestionResult(
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
              style: Theme.of(context).textTheme.displayMedium,
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
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                if (_agreementAnswerFormat.markdownDescription != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: MarkdownBody(
                      data: _agreementAnswerFormat.markdownDescription!,
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
                    Radio<BooleanResult>(
                        groupValue: _result,
                        value: BooleanResult.POSITIVE,
                        onChanged: (v) {
                          setState(() {
                            _result = v;
                          });
                        }),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_result == BooleanResult.POSITIVE) {
                            _result = BooleanResult.NEGATIVE;
                          } else {
                            _result = BooleanResult.POSITIVE;
                          }
                        });
                      },
                      child: MarkdownBody(
                        styleSheet: markDownStyleSheet.copyWith(
                          p: theme.textTheme.bodySmall,
                        ),
                        data:
                            _agreementAnswerFormat.markdownAgreementText ?? '',
                        onTapLink: (text, href, title) =>
                            href != null ? launchUrl(Uri.parse(href)) : null,
                      ),
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
