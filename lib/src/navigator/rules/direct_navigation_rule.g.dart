// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_navigation_rule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectNavigationRule _$DirectNavigationRuleFromJson(
        Map<String, dynamic> json) =>
    DirectNavigationRule(
      StepIdentifier.fromJson(
          json['destinationStepIdentifier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DirectNavigationRuleToJson(
        DirectNavigationRule instance) =>
    <String, dynamic>{
      'destinationStepIdentifier': instance.destinationStepIdentifier,
    };
