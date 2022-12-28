// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) => Step(
      id: json['id'] as String,
      title: json['title'] as String,
      content: (json['content'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isMandatory: json['isMandatory'] as bool? ?? true,
      answer: json['answer'] == null
          ? null
          : Answer.fromJson(json['answer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'isMandatory': instance.isMandatory,
      'answer': instance.answer,
    };
