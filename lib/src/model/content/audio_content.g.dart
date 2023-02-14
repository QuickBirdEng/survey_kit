// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioContent _$AudioContentFromJson(Map<String, dynamic> json) => AudioContent(
      url: json['url'] as String,
      id: json['id'] as String?,
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
  return val;
}
