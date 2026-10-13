import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(
  BuildContext context, {
  String hint = '',
}) {
  final borderSide = BorderSide(
    color: Theme.of(context).colorScheme.outlineVariant,
  );
  return InputDecoration(
    contentPadding: const EdgeInsets.all(10),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: borderSide,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: borderSide,
    ),
    hintText: hint,
  );
}
