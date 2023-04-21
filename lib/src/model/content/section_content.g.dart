// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionContent _$SectionContentFromJson(Map<String, dynamic> json) =>
    SectionContent(
      title: StyledText.fromJson(json['title'] as Map<String, dynamic>),
      subtitle: StyledText.fromJson(json['subtitle'] as Map<String, dynamic>),
      text: StyledText.fromJson(json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionContentToJson(SectionContent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'text': instance.text,
    };

StyledText _$StyledTextFromJson(Map<String, dynamic> json) => StyledText(
      text: json['text'] as String,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16,
      bold: json['bold'] as bool? ?? false,
      italic: json['italic'] as bool? ?? false,
      underlined: json['underlined'] as bool? ?? false,
    );

Map<String, dynamic> _$StyledTextToJson(StyledText instance) =>
    <String, dynamic>{
      'text': instance.text,
      'fontSize': instance.fontSize,
      'bold': instance.bold,
      'italic': instance.italic,
      'underlined': instance.underlined,
    };
