import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/answer/date_answer_format.dart';
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_choice_auto_complete_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_double_answer_format.dart';
import 'package:survey_kit/src/model/answer/scale_answer_format.dart';
import 'package:survey_kit/src/model/answer/single_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/answer/time_answer_format.dart';

@JsonSerializable()
abstract class AnswerFormat {
  const AnswerFormat({this.answerType, this.question});

  final String? question;
  @JsonKey(name: 'type')
  final String? answerType;

  static final Map<String, AnswerFormat Function(Map<String, dynamic>)>
      _converters = {
    BooleanAnswerFormat.type: BooleanAnswerFormat.fromJson,
    DateAnswerFormat.type: DateAnswerFormat.fromJson,
    DoubleAnswerFormat.type: DoubleAnswerFormat.fromJson,
    IntegerAnswerFormat.type: IntegerAnswerFormat.fromJson,
    MultipleChoiceAnswerFormat.type: (json) => MultipleChoiceAnswerFormat.fromJson(
      json,
      (e) => TextChoice.fromJson(e as Map<String, dynamic>),
    ),
    MultipleChoiceAutoCompleteAnswerFormat.type:
        MultipleChoiceAutoCompleteAnswerFormat.fromJson,
    MultipleDoubleAnswerFormat.type: MultipleDoubleAnswerFormat.fromJson,
    ScaleAnswerFormat.type: ScaleAnswerFormat.fromJson,
    SingleChoiceAnswerFormat.type: (json) => SingleChoiceAnswerFormat.fromJson(
      json,
      (e) => TextChoice.fromJson(e as Map<String, dynamic>),
    ),
    TextAnswerFormat.type: TextAnswerFormat.fromJson,
    TimeAnswerFormat.type: TimeAnswerFormat.fromJson,
  };

  static void registerFromJson(
    String type,
    AnswerFormat Function(Map<String, dynamic>) factory,
  ) {
    _converters[type] = factory;
  }

  factory AnswerFormat.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    final converter = _converters[type];
    if (converter != null) {
      return converter(json);
    }

    throw Exception('Unknown type: $type');
  }
  Map<String, dynamic> toJson();
}
