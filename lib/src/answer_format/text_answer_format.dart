import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

part 'text_answer_format.g.dart';

@JsonSerializable()
class TextAnswerFormat implements AnswerFormat {
  const TextAnswerFormat({
    this.maxLines,
    this.hint = '',
    this.defaultValue,
    this.validationRegEx = '^(?!\s*\$).+',
    this.decoration,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
  });

  factory TextAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$TextAnswerFormatFromJson(json);
  Map<String, dynamic> toJson() => _$TextAnswerFormatToJson(this);

  final int? maxLines;
  final String? defaultValue;
  @JsonKey(defaultValue: '')
  final String hint;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final InputDecoration? decoration;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<TextInputFormatter>? inputFormatters;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final TextCapitalization textCapitalization;

  @JsonKey(includeFromJson: false, includeToJson: false)
  final TextInputType? keyboardType;

  /// Regular expression by which the text gets validated
  /// default: '^(?!\s*$).+' that checks if the entered text is empty
  /// to allow any type of an answer including an empty one;
  /// set it explicitly to null.
  ///
  @JsonKey(defaultValue: '^(?!\s*\$).+')
  final String? validationRegEx;
}
