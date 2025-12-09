// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeResult _$TimeResultFromJson(Map<String, dynamic> json) => TimeResult(
      timeOfDay:
          const _TimeOfDayConverter().fromJson(json['timeOfDay'] as String?),
    );

Map<String, dynamic> _$TimeResultToJson(TimeResult instance) =>
    <String, dynamic>{
      'timeOfDay': const _TimeOfDayConverter().toJson(instance.timeOfDay),
    };
