import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/answer/multi_select_answer.dart';
import 'package:survey_kit/src/_new/model/answer/single_select_answer.dart';

@JsonSerializable()
abstract class Answer {
  const Answer();

  factory Answer.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    switch (type) {
      case MultiSelectAnswer.type:
        return MultiSelectAnswer.fromJson(json);
      case SingleSelectAnswer.type:
        return SingleSelectAnswer.fromJson(json);

      default:
        throw Exception('Unknown type: $type');
    }
  }
}
