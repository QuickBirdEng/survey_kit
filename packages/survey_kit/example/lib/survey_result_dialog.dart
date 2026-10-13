import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

Future<void> showSurveyResultDialog(
  BuildContext context,
  SurveyResult result, {
  String actionLabel = 'Restart',
}) {
  final json = const JsonEncoder.withIndent('  ').convert(result.toJson());
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Result (${result.finishReason.name})'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Text(json, style: const TextStyle(fontFamily: 'monospace')),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(actionLabel),
        ),
      ],
    ),
  );
}
