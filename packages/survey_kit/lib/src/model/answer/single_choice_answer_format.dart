import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';

part 'single_choice_answer_format.g.dart';

@JsonSerializable(genericArgumentFactories: true, explicitToJson: true)
class SingleChoiceAnswerFormat<T extends TextChoice> extends AnswerFormat {
  static const String type = 'single';

  final List<T> textChoices;
  final T? defaultSelection;

  const SingleChoiceAnswerFormat({
    required this.textChoices,
    this.defaultSelection,
    super.question,
    super.answerType = SingleChoiceAnswerFormat.type,
  }) : super();

  factory SingleChoiceAnswerFormat.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$SingleChoiceAnswerFormatFromJson(json, fromJsonT);

  @override
  Map<String, dynamic> toJson() => _$SingleChoiceAnswerFormatToJson(
        this,
        (value) => value.toJson(),
      );
}
