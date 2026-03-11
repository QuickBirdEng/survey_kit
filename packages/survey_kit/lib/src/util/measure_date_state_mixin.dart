import 'package:flutter/material.dart';

/// A [State] mixin that records the [DateTime] when the state is initialized.
/// Mix this into any answer view state to capture when the user first saw the
/// step.
mixin MeasureDateStateMixin<T extends StatefulWidget> on State<T> {
  /// The date and time when [initState] was called.
  late final DateTime startDate;
  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
  }
}
