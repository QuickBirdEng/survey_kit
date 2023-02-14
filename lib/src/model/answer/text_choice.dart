import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'text_choice.g.dart';

@JsonSerializable()
class TextChoice {
  final String id;
  final String text;
  @JsonKey(includeIfNull: false)
  final String? value;

  TextChoice({
    String? id,
    required this.text,
    this.value,
  }) : id = id ?? const Uuid().v4();

  factory TextChoice.fromJson(Map<String, dynamic> json) =>
      _$TextChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$TextChoiceToJson(this);
}
