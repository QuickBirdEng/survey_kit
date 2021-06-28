// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'completion_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompletionStep _$CompletionStepFromJson(Map<String, dynamic> json) {
  return CompletionStep(
    isOptional: json['isOptional'] as bool? ?? false,
    stepIdentifier:
        StepIdentifier.fromJson(json['stepIdentifier'] as Map<String, dynamic>),
    buttonText: json['buttonText'] as String? ?? 'Next',
    title: json['title'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$CompletionStepToJson(CompletionStep instance) =>
    <String, dynamic>{
      'stepIdentifier': instance.stepIdentifier,
      'isOptional': instance.isOptional,
      'buttonText': instance.buttonText,
      'title': instance.title,
      'text': instance.text,
    };
