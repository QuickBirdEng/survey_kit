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

/// Abstract base class for all answer format types. Defines how a survey
/// question accepts user input. Use [AnswerFormat.fromJson] for
/// deserialization. Register custom types with [registerFromJson].
@JsonSerializable()
abstract class AnswerFormat {
  const AnswerFormat({this.answerType, this.question});

  /// Optional question text associated with this answer format.
  final String? question;

  /// JSON type discriminator used during deserialization.
  @JsonKey(name: 'type')
  final String? answerType;

  static final Map<String, AnswerFormat Function(Map<String, dynamic>)>
      _converters = {
    BooleanAnswerFormat.type: BooleanAnswerFormat.fromJson,
    DateAnswerFormat.type: DateAnswerFormat.fromJson,
    DoubleAnswerFormat.type: DoubleAnswerFormat.fromJson,
    IntegerAnswerFormat.type: IntegerAnswerFormat.fromJson,
    MultipleChoiceAnswerFormat.type: (json) =>
        MultipleChoiceAnswerFormat.fromJson(
          json,
          (dynamic e) => TextChoice.fromJson(e as Map<String, dynamic>),
        ),
    MultipleChoiceAutoCompleteAnswerFormat.type:
        MultipleChoiceAutoCompleteAnswerFormat.fromJson,
    MultipleDoubleAnswerFormat.type: MultipleDoubleAnswerFormat.fromJson,
    ScaleAnswerFormat.type: ScaleAnswerFormat.fromJson,
    SingleChoiceAnswerFormat.type: (json) => SingleChoiceAnswerFormat.fromJson(
          json,
          (dynamic e) => TextChoice.fromJson(e as Map<String, dynamic>),
        ),
    TextAnswerFormat.type: TextAnswerFormat.fromJson,
    TimeAnswerFormat.type: TimeAnswerFormat.fromJson,
  };

  /// Registers a custom [AnswerFormat] subtype for JSON deserialization.
  /// Call this before loading any survey JSON that contains [type].
  static void registerFromJson(
    String type,
    AnswerFormat Function(Map<String, dynamic>) factory,
  ) {
    _converters[type] = factory;
  }

  /// Deserializes an [AnswerFormat] from [json]. Dispatches to the registered
  /// factory for the 'type' field. Throws if the type is unknown.
  factory AnswerFormat.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    final converter = _converters[type];
    if (converter != null) {
      return converter(json);
    }

    throw Exception('Unknown type: $type');
  }
  /// Serializes this answer format to a JSON map.
  Map<String, dynamic> toJson();
}
