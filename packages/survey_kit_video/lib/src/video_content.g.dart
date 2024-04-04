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
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      externalLink: json['externalLink'] as String?,
    );

Map<String, dynamic> _$VideoContentToJson(VideoContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['url'] = instance.url;
  val['autoPlay'] = instance.autoPlay;
  val['loop'] = instance.loop;
  val['width'] = instance.width;
  val['height'] = instance.height;
  val['title'] = instance.title;
  val['subtitle'] = instance.subtitle;
  val['externalLink'] = instance.externalLink;
  return val;
}
