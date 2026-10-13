import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';

part 'boolean_answer_format.g.dart';

/// Answer format that presents a yes/no choice. Renders as two mutually
/// exclusive buttons. The JSON type identifier is `'bool'`.
@JsonSerializable()
class BooleanAnswerFormat extends AnswerFormat {
  /// JSON type identifier for this format.
  static const String type = 'bool';

  /// Label for the positive (yes) option.
  final String positiveAnswer;

  /// Label for the negative (no) option.
  final String negativeAnswer;

  /// Pre-selected option when the question is first shown.
  /// Defaults to [BooleanResult.none].
  @JsonKey(name: 'result')
  final BooleanResult defaultValue;

  const BooleanAnswerFormat({
    required this.positiveAnswer,
    required this.negativeAnswer,
    this.defaultValue = BooleanResult.none,
    super.question,
    @Deprecated(
      'Built-in formats set their own type; pass it only to keep a custom type string.',
    )
    String? answerType,
  }) : super(answerType: answerType ?? BooleanAnswerFormat.type);

  factory BooleanAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$BooleanAnswerFormatFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BooleanAnswerFormatToJson(this);
}

/// The result of a [BooleanAnswerFormat] question.
/// [none] means no selection, [positive] means yes, [negative] means no.
@JsonEnum()
enum BooleanResult { none, positive, negative }
