// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoStep _$VideoStepFromJson(Map<String, dynamic> json) {
  return VideoStep(
    url: json['url'] as String,
    isAutoPlay: json['isAutoPlay'] as bool? ?? false,
    isAutomaticFullscreen: json['isAutomaticFullscreen'] as bool? ?? false,
    goToNextPageAfterEnd: json['goToNextPageAfterEnd'] as bool? ?? false,
    isLooping: json['isLooping'] as bool? ?? false,
    allowMuting: json['allowMuting'] as bool? ?? false,
    width: (json['width'] as num?)?.toDouble(),
    height: (json['height'] as num?)?.toDouble(),
    isOptional: json['isOptional'] as bool? ?? false,
    buttonText: json['buttonText'] as String? ?? 'Next',
    stepIdentifier: json['stepIdentifier'] == null
        ? null
        : StepIdentifier.fromJson(
            json['stepIdentifier'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VideoStepToJson(VideoStep instance) => <String, dynamic>{
      'stepIdentifier': instance.stepIdentifier,
      'isOptional': instance.isOptional,
      'buttonText': instance.buttonText,
      'isAutoPlay': instance.isAutoPlay,
      'isAutomaticFullscreen': instance.isAutomaticFullscreen,
      'goToNextPageAfterEnd': instance.goToNextPageAfterEnd,
      'isLooping': instance.isLooping,
      'allowMuting': instance.allowMuting,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };
