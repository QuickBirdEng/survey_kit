import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/answer/answer.dart';
import 'package:survey_kit/src/_new/model/module.dart';

part 'step.g.dart';

@JsonSerializable()
class Step extends Module {
  final bool isMandatory;
  final Answer? answer;

  const Step({
    required super.id,
    required super.title,
    required super.content,
    super.description,
    super.imageUrl,
    this.isMandatory = true,
    this.answer,
  });

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
  Map<String, dynamic> toJson() => _$StepToJson(this);
}
