// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoContent _$VideoContentFromJson(Map<String, dynamic> json) => VideoContent(
      url: json['url'] as String,
      id: json['id'] as String?,
      autoPlay: json['autoPlay'] as bool? ?? false,
      loop: json['loop'] as bool? ?? false,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$VideoContentToJson(VideoContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'autoPlay': instance.autoPlay,
      'loop': instance.loop,
      'width': instance.width,
      'height': instance.height,
    };
