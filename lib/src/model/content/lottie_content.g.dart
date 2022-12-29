// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lottie_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LottieContent _$LottieContentFromJson(Map<String, dynamic> json) =>
    LottieContent(
      id: json['id'] as String,
      asset: json['asset'] as String,
      repeat: json['repeat'] as bool? ?? false,
    );

Map<String, dynamic> _$LottieContentToJson(LottieContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'asset': instance.asset,
      'repeat': instance.repeat,
    };
