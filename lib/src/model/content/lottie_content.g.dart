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

Map<String, dynamic> _$LottieContentToJson(LottieContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'asset': instance.asset,
      'repeat': instance.repeat,
      'width': instance.width,
      'height': instance.height,
    };
