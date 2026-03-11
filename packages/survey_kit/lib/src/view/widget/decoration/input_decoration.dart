import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration({String hint = ''}) => InputDecoration(
      contentPadding: const EdgeInsets.only(
        left: 10,
        bottom: 10,
        top: 10,
        right: 10,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black.withValues(alpha: .2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.black.withValues(alpha: .2),
        ),
      ),
      hintText: hint,
    );
