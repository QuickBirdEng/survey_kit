// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instruction_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstructionStep _$InstructionStepFromJson(Map<String, dynamic> json) =>
    InstructionStep(
      title: json['title'] as String,
      text: json['text'] as String,
      isOptional: json['isOptional'] as bool? ?? false,
      buttonText: json['buttonText'] as String? ?? 'Next',
      stepIdentifier: json['stepIdentifier'] == null
          ? null
          : StepIdentifier.fromJson(
              json['stepIdentifier'] as Map<String, dynamic>),
      canGoBack: json['canGoBack'] as bool?,
      showProgress: json['showProgress'] as bool?,
      showAppBar: json['showAppBar'] as bool? ?? true,
    );

Map<String, dynamic> _$InstructionStepToJson(InstructionStep instance) =>
    <String, dynamic>{
      'stepIdentifier': instance.stepIdentifier.toJson(),
      'isOptional': instance.isOptional,
      'buttonText': instance.buttonText,
      'canGoBack': instance.canGoBack,
      'showProgress': instance.showProgress,
      'showAppBar': instance.showAppBar,
      'title': instance.title,
      'text': instance.text,
    };
