// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageContent _$ImageContentFromJson(Map<String, dynamic> json) => ImageContent(
      id: json['id'] as String?,
      url: json['url'] as String,
      fit: $enumDecodeNullable(_$BoxFitEnumMap, json['fit']),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ImageContentToJson(ImageContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['url'] = instance.url;
  val['fit'] = _$BoxFitEnumMap[instance.fit];
  val['width'] = instance.width;
  val['height'] = instance.height;
  return val;
}

const _$BoxFitEnumMap = {
  BoxFit.fill: 'fill',
  BoxFit.contain: 'contain',
  BoxFit.cover: 'cover',
  BoxFit.fitWidth: 'fitWidth',
  BoxFit.fitHeight: 'fitHeight',
  BoxFit.none: 'none',
  BoxFit.scaleDown: 'scaleDown',
};
