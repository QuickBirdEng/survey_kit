import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/answer/answer_format.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/model/module.dart';
import 'package:uuid/uuid.dart';

@JsonSerializable()
class Step extends Module {
  final bool isMandatory;
  final AnswerFormat? answerFormat;
  final String? buttonText;

  Step({
    String? id,
    required super.content,
    super.title = '',
    super.description,
    super.imageUrl,
    this.isMandatory = true,
    this.answerFormat,
    this.buttonText,
  }) : super(id: id ?? const Uuid().v4());

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        id: json['id'] as String,
        title: json['title'] as String,
        content: (json['content'] as List<dynamic>)
            .map((dynamic e) => Content.fromJson(e as Map<String, dynamic>))
            .toList(),
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
        isMandatory: json['isMandatory'] as bool? ?? true,
        answerFormat: json['answerFormat'] == null
            ? null
            : AnswerFormat.fromJson(
                json['answerFormat'] as Map<String, dynamic>,
              ),
        buttonText: json['buttonText'] as String?,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'content': content,
        'description': description,
        'imageUrl': imageUrl,
        'isMandatory': isMandatory,
        'answer': answerFormat,
        'buttonText': buttonText,
      };
}
