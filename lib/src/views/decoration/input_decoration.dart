import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration({String hint = ''}) => InputDecoration(
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
