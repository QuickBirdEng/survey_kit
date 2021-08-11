import 'package:flutter/material.dart';

class SurveyProgressConfiguration {
  final Color progressbarColor;
  final Color? valueProgressbarColor;
  final Color? backgroundColor;
  final double height;
  final EdgeInsets padding;
  final bool showLabel;
  final Function(String from, String to)? label;

  SurveyProgressConfiguration({
    this.progressbarColor = Colors.white,
    this.height = 6.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0),
    this.showLabel = false,
    this.label,
    this.backgroundColor,
    this.valueProgressbarColor,
  });
}
