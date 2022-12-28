// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Glossary _$GlossaryFromJson(Map<String, dynamic> json) => Glossary(
      id: json['id'] as String,
      title: json['title'] as String,
      content: (json['content'] as List<dynamic>)
          .map((e) => Content.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$GlossaryToJson(Glossary instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
