import 'package:flutter/material.dart';

mixin MeasureDateStateMixin<T extends StatefulWidget> on State<T> {
  late final DateTime startDate;
  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
  }
}
