// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_choice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextChoice _$TextChoiceFromJson(Map<String, dynamic> json) => TextChoice(
      id: json['id'] as String?,
      text: json['text'] as String,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$TextChoiceToJson(TextChoice instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'text': instance.text,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  return val;
}
