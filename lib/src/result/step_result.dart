import 'package:survey_kit/src/result/question/boolean_question_result.dart';
import 'package:survey_kit/src/result/question/date_question_result.dart';
import 'package:survey_kit/src/result/question/double_question_result.dart';
import 'package:survey_kit/src/result/question/integer_question_result.dart';
import 'package:survey_kit/src/result/question/multiple_choice_question_result.dart';
import 'package:survey_kit/src/result/question/multiple_double_question_result.dart';
import 'package:survey_kit/src/result/question/scale_question_result.dart';
import 'package:survey_kit/src/result/question/single_choice_question_result.dart';
import 'package:survey_kit/src/result/question/text_question_result.dart';
import 'package:survey_kit/src/result/question/time_question_result.dart';
import 'package:survey_kit/src/result/result.dart';
import 'package:survey_kit/src/result/step/completion_step_result.dart';
import 'package:survey_kit/src/result/step/instruction_step_result.dart';
import 'package:survey_kit/src/result/step/video_step_result.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/src/result/question_result.dart';

import 'package:json_annotation/json_annotation.dart';

part 'step_result.g.dart';

@JsonSerializable(explicitToJson: true)
class StepResult extends Result {
  @_Converter()
  final List<QuestionResult> results;

  StepResult(
      {required Identifier? id,
      required DateTime startDate,
      required DateTime endDate,
      required this.results})
      : super(id: id, startDate: startDate, endDate: endDate);

  factory StepResult.fromQuestion({required QuestionResult questionResult}) {
    return StepResult(
      id: questionResult.id,
      startDate: questionResult.startDate,
      endDate: questionResult.endDate,
      results: [questionResult],
    );
  }

  factory StepResult.fromJson(Map<String, dynamic> json) =>
      _$StepResultFromJson(json);

  Map<String, dynamic> toJson() => _$StepResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate];
}

class _Converter implements JsonConverter<List<QuestionResult>, Object> {
  const _Converter();

  @override
  Object toJson(List<QuestionResult> questionResults) {
    List<Map<String, dynamic>> allQuestionResultsEncoded = [];

    for (QuestionResult qr in questionResults) {
      if (qr is BooleanQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (BooleanQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is DateQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (DateQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is DoubleQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (DoubleQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is IntegerQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (IntegerQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is MultipleDoubleQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (MultipleDoubleQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is MultipleDoubleQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (MultipleDoubleQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is MultipleChoiceQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (MultipleChoiceQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is ScaleQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (ScaleQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is SingleChoiceQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (SingleChoiceQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is TextQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (TextQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is TimeQuestionResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (TimeQuestionResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is InstructionStepResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (InstructionStepResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is CompletionStepResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (CompletionStepResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else if (qr is VideoStepResult) {
        final qrJson = qr.toJson();
        qrJson['type'] = (VideoStepResult).toString();
        allQuestionResultsEncoded.add(qrJson);
      } else {
        throw ('Unhandled Question Result Type');
      }
    }

    return allQuestionResultsEncoded;
  }

  @override
  List<QuestionResult> fromJson(Object json) {
    final List<QuestionResult> results = [];
    for (var element in json as List<dynamic>) {
      final qData = element as Map<String, dynamic>;
      final qType = qData['type'] as String;

      if (qType == (BooleanQuestionResult).toString()) {
        results.add(BooleanQuestionResult.fromJson(qData));
      } else if (qType == (DateQuestionResult).toString()) {
        results.add(DateQuestionResult.fromJson(qData));
      } else if (qType == (DoubleQuestionResult).toString()) {
        results.add(DoubleQuestionResult.fromJson(qData));
      } else if (qType == (IntegerQuestionResult).toString()) {
        results.add(IntegerQuestionResult.fromJson(qData));
      } else if (qType == (MultipleChoiceQuestionResult).toString()) {
        results.add(MultipleChoiceQuestionResult.fromJson(qData));
      } else if (qType == (MultipleDoubleQuestionResult).toString()) {
        results.add(MultipleDoubleQuestionResult.fromJson(qData));
      } else if (qType == (ScaleQuestionResult).toString()) {
        results.add(ScaleQuestionResult.fromJson(qData));
      } else if (qType == (SingleChoiceQuestionResult).toString()) {
        results.add(SingleChoiceQuestionResult.fromJson(qData));
      } else if (qType == (TextQuestionResult).toString()) {
        results.add(TextQuestionResult.fromJson(qData));
      } else if (qType == (TimeQuestionResult).toString()) {
        results.add(TimeQuestionResult.fromJson(qData));
      } else if (qType == (InstructionStepResult).toString()) {
        results.add(InstructionStepResult.fromJson(qData));
      } else if (qType == (CompletionStepResult).toString()) {
        results.add(CompletionStepResult.fromJson(qData));
      } else if (qType == (VideoStepResult).toString()) {
        results.add(VideoStepResult.fromJson(qData));
      } else {
        throw ('Unhandled Question Result Type');
      }
    }

    return results;
  }
}
