import 'package:json_annotation/json_annotation.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime json) {
    // Ignore microseconds and preserve timezone
    final date = json.isUtc
        ? DateTime.utc(
            json.year,
            json.month,
            json.day,
            json.hour,
            json.minute,
            json.second,
            json.millisecond,
          )
        : DateTime(
            json.year,
            json.month,
            json.day,
            json.hour,
            json.minute,
            json.second,
            json.millisecond,
          ).toUtc();

    return date.toIso8601String();
  }
}
