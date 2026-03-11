import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'text_choice.g.dart';

@immutable
@JsonSerializable()
class TextChoice {
  final String id;
  final String text;

  final String? value;

  TextChoice({
    String? id,
    required this.text,
    this.value,
  }) : id = id ?? const Uuid().v4();

  factory TextChoice.fromJson(Map<String, dynamic> json) =>
      _$TextChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$TextChoiceToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextChoice &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          value == other.value;

  @override
  int get hashCode => Object.hash(id, text, value);
}
