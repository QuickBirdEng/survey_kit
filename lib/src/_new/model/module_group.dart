import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/module.dart';

part 'module_group.g.dart';

@JsonSerializable()
class ModuleGroup {
  final String id;
  final String text;
  final String? description;
  final String? imageUrl;
  final List<Module> modules;

  const ModuleGroup({
    required this.id,
    required this.text,
    required this.modules,
    this.description,
    this.imageUrl,
  });

  factory ModuleGroup.fromJson(Map<String, dynamic> json) =>
      _$ModuleGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ModuleGroupToJson(this);
}
