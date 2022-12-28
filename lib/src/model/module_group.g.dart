// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleGroup _$ModuleGroupFromJson(Map<String, dynamic> json) => ModuleGroup(
      id: json['id'] as String,
      text: json['text'] as String,
      modules: (json['modules'] as List<dynamic>)
          .map((e) => Module.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$ModuleGroupToJson(ModuleGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'modules': instance.modules,
    };
