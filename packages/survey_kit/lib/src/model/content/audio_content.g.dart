// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioContent _$AudioContentFromJson(Map<String, dynamic> json) => AudioContent(
      url: json['url'] as String,
      id: json['id'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      externalLink: json['externalLink'] as String?,
    );

Map<String, dynamic> _$AudioContentToJson(AudioContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['url'] = instance.url;
  val['title'] = instance.title;
  val['subtitle'] = instance.subtitle;
  val['externalLink'] = instance.externalLink;
  return val;
}
