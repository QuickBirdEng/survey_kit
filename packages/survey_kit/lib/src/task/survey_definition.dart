import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/task/survey_flow.dart';
import 'package:survey_kit/src/task/task_not_defined_exception.dart';
import 'package:uuid/uuid.dart';

/// Abstract definition of a survey.
///
/// If you want to create a custom survey definition:
///  * Inherit from [SurveyDefinition]
///  * If you want to use JSON, override [fromJson] and add your type
@immutable
abstract class SurveyDefinition {
  /// Unique identifier for this survey definition.
  /// Auto-generated with UUID if not provided.
  late final String id;

  /// The ordered list of steps in the survey.
  @JsonKey(defaultValue: <Step>[])
  final List<Step> steps;

  /// An optional step to show first, overriding the first item in [steps].
  final Step? initialStep;

  SurveyDefinition({
    String? id,
    this.steps = const [],
    this.initialStep,
  }) : id = id ?? const Uuid().v4();

  /// Creates a survey definition from a Map. The survey needs one of:
  ///  * 'flow' - [SurveyFlow]
  ///  * 'ordered' (legacy)
  ///  * 'navigable' (legacy)
  /// If not it throws a [TaskNotDefinedException].
  factory SurveyDefinition.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    if (type == SurveyFlow.type || type == 'ordered' || type == 'navigable') {
      return SurveyFlow.fromJson(json);
    }
    throw const TaskNotDefinedException();
  }

  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) => other is SurveyDefinition && other.id == id;
  @override
  int get hashCode => id.hashCode ^ steps.hashCode;
}
