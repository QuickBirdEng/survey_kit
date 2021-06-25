import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';

part 'task_identifier.g.dart';

@JsonSerializable()
class TaskIdentifier extends Identifier {
  TaskIdentifier({String? id}) : super(id: id);

  factory TaskIdentifier.fromJson(Map<String, dynamic> json) =>
      _$TaskIdentifierFromJson(json);
  Map<String, dynamic> toJson() => _$TaskIdentifierToJson(this);
}
