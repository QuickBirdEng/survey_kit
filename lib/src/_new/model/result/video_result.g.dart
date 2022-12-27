// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoResult _$VideoResultFromJson(Map<String, dynamic> json) => VideoResult(
      leftVideoAt: Duration(microseconds: json['leftVideoAt'] as int),
      stayedInVideo: DateTime.parse(json['stayedInVideo'] as String),
    );

Map<String, dynamic> _$VideoResultToJson(VideoResult instance) =>
    <String, dynamic>{
      'leftVideoAt': instance.leftVideoAt.inMicroseconds,
      'stayedInVideo': instance.stayedInVideo.toIso8601String(),
    };
