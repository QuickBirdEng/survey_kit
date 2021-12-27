import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration({String hint = ''}) => InputDecoration(
      contentPadding: const EdgeInsets.only(
        left: 8,
        bottom: 8,
        top: 8,
        right: 8,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.zero,
        ),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.zero,
        ),
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
      hintText: hint,
    );
