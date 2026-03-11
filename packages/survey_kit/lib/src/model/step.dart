import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/survey_kit.dart';
import 'package:uuid/uuid.dart';

part 'step.g.dart';

/// A single unit of a survey. A step can display content (text, images,
/// markdown) and optionally collect a user answer via [answerFormat]. Steps
/// are identified by [id] which is auto-generated if not provided.
@immutable
@JsonSerializable(explicitToJson: true)
class Step {
  /// Unique identifier for this step. Auto-generated with UUID if not provided.
  final String id;

  /// Whether the user must answer before proceeding. Defaults to true.
  final bool isMandatory;

  /// The answer format that determines how the user inputs a response.
  /// Null for display-only steps (e.g. instruction, completion).
  final AnswerFormat? answerFormat;

  /// Custom label for the 'Next' button. Uses the localized default if null.
  final String? buttonText;

  /// The list of [Content] items displayed on this step (text, images, markdown, etc.).
  final List<Content> content;

  @JsonKey(includeFromJson: false, includeToJson: false)
  /// Optional custom widget builder that wraps this step's UI.
  /// Overrides the survey-level [StepShell].
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
