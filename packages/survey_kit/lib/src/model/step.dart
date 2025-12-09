import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/survey_kit.dart';
import 'package:uuid/uuid.dart';

part 'step.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Step {
  final String id;
  final bool isMandatory;
  final AnswerFormat? answerFormat;

  final String? buttonText;
  final List<Content> content;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StepShell? stepShell;

  Step({
    String? id,
    required this.content,
    this.isMandatory = true,
    this.answerFormat,
    this.buttonText,
    this.stepShell,
  }) : id = id ?? const Uuid().v4();

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Step) return false;
    if (runtimeType != other.runtimeType) return false;

    return id == other.id &&
        isMandatory == other.isMandatory &&
        answerFormat == other.answerFormat &&
        buttonText == other.buttonText &&
        _listEquals(content, other.content);
  }

  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (var index = 0; index < a.length; index += 1) {
      if (a[index] != b[index]) return false;
    }
    return true;
  }

  @override
  int get hashCode =>
      Object.hash(id, isMandatory, answerFormat, buttonText, content.length);
}
