import 'package:flutter/material.dart';
import 'package:survey_kit/src/view/widget/answer/answer_question_text.dart';
import 'package:survey_kit/src/view/widget/decoration/input_decoration.dart';

class AnswerTextField extends StatelessWidget {
  const AnswerTextField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.questionText,
    this.hint = '',
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
    this.padding = const EdgeInsets.symmetric(vertical: 14.0),
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String? questionText;
  final String hint;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int? maxLines;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final questionText = this.questionText;

    return Padding(
      padding: padding,
      child: Column(
        children: [
          if (questionText != null) AnswerQuestionText(text: questionText),
          SizedBox(
            width: double.infinity,
            child: TextField(
              textInputAction: textInputAction,
              autofocus: true,
              decoration: textFieldInputDecoration(context, hint: hint),
              controller: controller,
              onChanged: onChanged,
              keyboardType: keyboardType,
              maxLines: maxLines,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
