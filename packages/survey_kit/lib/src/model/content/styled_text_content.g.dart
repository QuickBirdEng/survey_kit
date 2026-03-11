// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'styled_text_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StyledTextContent _$StyledTextContentFromJson(Map<String, dynamic> json) =>
    StyledTextContent(
      text: json['text'] as String,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16,
      bold: json['bold'] as bool? ?? false,
      italic: json['italic'] as bool? ?? false,
      underlined: json['underlined'] as bool? ?? false,
    );

Map<String, dynamic> _$StyledTextContentToJson(StyledTextContent instance) =>
    <String, dynamic>{
      'text': instance.text,
      'fontSize': instance.fontSize,
      'bold': instance.bold,
      'italic': instance.italic,
      'underlined': instance.underlined,
    };
