import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_choice.g.dart';

@JsonSerializable()
@immutable
class TextChoice {
  final String text;
  final String value;

  const TextChoice({
    required this.text,
    required this.value,
  }) : super();

  factory TextChoice.fromJson(Map<String, dynamic> json) =>
      _$TextChoiceFromJson(json);
  Map<String, dynamic> toJson() => _$TextChoiceToJson(this);

  @override
  bool operator ==(Object other) =>
      other is TextChoice && text == other.text && value == other.value;
  @override
  int get hashCode => text.hashCode ^ value.hashCode;
}
