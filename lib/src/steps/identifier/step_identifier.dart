import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';

part 'step_identifier.g.dart';

@JsonSerializable()
class StepIdentifier extends Identifier {
  StepIdentifier({String? id}) : super(id: id);

  factory StepIdentifier.fromJson(Map<String, dynamic> json) =>
      _$StepIdentifierFromJson(json);
  Map<String, dynamic> toJson() => _$StepIdentifierToJson(this);

  bool operator ==(o) => o is StepIdentifier && id == o.id;
  int get hashCode => id.hashCode;
}
