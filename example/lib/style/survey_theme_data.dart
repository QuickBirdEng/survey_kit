import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ThemeData surveyThemeData(BuildContext context) {
  return Theme.of(context).copyWith(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.cyan,
    ).copyWith(
      onPrimary: Colors.white,
    ),
    primaryColor: Colors.cyan,
    backgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.cyan,
      ),
      titleTextStyle: TextStyle(
        color: Colors.cyan,
      ),
    ),
    iconTheme: const IconThemeData(
      color: Colors.cyan,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.cyan,
      selectionColor: Colors.cyan,
      selectionHandleColor: Colors.cyan,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      primaryColor: Colors.cyan,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          Size(150.0, 60.0),
        ),
        side: MaterialStateProperty.resolveWith(
          (Set<MaterialState> state) {
            if (state.contains(MaterialState.disabled)) {
              return BorderSide(
                color: Colors.grey,
              );
            }
            return BorderSide(
              color: Colors.cyan,
            );
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (Set<MaterialState> state) {
            if (state.contains(MaterialState.disabled)) {
              return Theme.of(context).textTheme.button?.copyWith(
                    color: Colors.grey,
                  );
            }
            return Theme.of(context).textTheme.button?.copyWith(
                  color: Colors.cyan,
                );
          },
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          Theme.of(context).textTheme.button?.copyWith(
                color: Colors.cyan,
              ),
        ),
      ),
    ),
    textTheme: TextTheme(
      headline2: TextStyle(
        fontSize: 28.0,
        color: Colors.black,
      ),
      headline5: TextStyle(
        fontSize: 24.0,
        color: Colors.black,
      ),
      bodyText2: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.black,
      ),
    ),
  );
}
