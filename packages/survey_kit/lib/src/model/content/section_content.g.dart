// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionContent _$SectionContentFromJson(Map<String, dynamic> json) =>
    SectionContent(
      title: StyledTextContent.fromJson(json['title'] as Map<String, dynamic>),
      subtitle:
          StyledTextContent.fromJson(json['subtitle'] as Map<String, dynamic>),
      text: StyledTextContent.fromJson(json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionContentToJson(SectionContent instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'text': instance.text,
    };
