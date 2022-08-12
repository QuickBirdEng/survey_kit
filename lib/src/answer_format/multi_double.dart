import 'package:json_annotation/json_annotation.dart';

part 'multi_double.g.dart';

@JsonSerializable()
class MultiDouble {
  final String text;
  final double value;

  MultiDouble({
    required this.text,
    required this.value,
  }) : super();

  factory MultiDouble.fromJson(Map<String, dynamic> json) =>
      _$MultiDoubleFromJson(json);
  Map<String, dynamic> toJson() => _$MultiDoubleToJson(this);

  bool operator ==(o) => o is MultiDouble && text == o.text && value == o.value;
  int get hashCode => text.hashCode ^ value.hashCode;
}
