import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multi_double.g.dart';

@JsonSerializable()
@immutable
class MultiDouble {
  final String text;
  final double value;

  const MultiDouble({
    required this.text,
    required this.value,
  }) : super();

  factory MultiDouble.fromJson(Map<String, dynamic> json) =>
      _$MultiDoubleFromJson(json);
  Map<String, dynamic> toJson() => _$MultiDoubleToJson(this);

  @override
  bool operator ==(Object other) =>
      other is MultiDouble && text == other.text && value == other.value;
  @override
  int get hashCode => text.hashCode ^ value.hashCode;
}
