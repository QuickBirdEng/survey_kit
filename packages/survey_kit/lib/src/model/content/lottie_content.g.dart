// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottie_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LottieContent _$LottieContentFromJson(Map<String, dynamic> json) =>
    LottieContent(
      url: json['url'] as String?,
      asset: json['asset'] as String?,
      repeat: json['repeat'] as bool? ?? false,
      width: (json['width'] as num?)?.toDouble() ?? 100,
      height: (json['height'] as num?)?.toDouble() ?? 100,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$LottieContentToJson(LottieContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['url'] = instance.url;
  val['asset'] = instance.asset;
  val['repeat'] = instance.repeat;
  val['width'] = instance.width;
  val['height'] = instance.height;
  return val;
}
