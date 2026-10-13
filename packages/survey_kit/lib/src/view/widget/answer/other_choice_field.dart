import 'package:flutter/material.dart';
import 'package:survey_kit/gen/survey_kit_localizations.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';

const otherChoiceId = 'Other';

List<TextChoice> replaceOtherChoice(
  List<TextChoice> selectedChoices,
  String otherText,
) {
  if (otherText.isEmpty) {
    return selectedChoices
        .where((choice) => choice.id != otherChoiceId)
        .toList();
  }
  final otherChoice = TextChoice(
    id: otherChoiceId,
    value: otherText,
    text: otherText,
  );
  final otherIndex = selectedChoices.indexWhere(
    (choice) => choice.id == otherChoiceId,
  );
  if (otherIndex == -1) {
    return [...selectedChoices, otherChoice];
  }
  return [...selectedChoices]..[otherIndex] = otherChoice;
}

String? findOtherChoiceText(List<TextChoice> selectedChoices) {
  for (final choice in selectedChoices) {
    if (choice.id == otherChoiceId) {
      return choice.text;
    }
  }
  return null;
}

class OtherChoiceField extends StatelessWidget {
  const OtherChoiceField({
    super.key,
    required this.onChanged,
    this.initialValue,
    this.padding = const EdgeInsets.symmetric(vertical: 4.0),
  });

  final ValueChanged<String> onChanged;
  final String? initialValue;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = SurveyKitLocalizations.of(context);

    return Padding(
      padding: padding,
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: localizations?.otherLabel ?? 'Other',
          labelStyle: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          hintText: localizations?.otherHint ?? 'Write other information here',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 16.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
