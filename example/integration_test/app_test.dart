// This is a basic Flutter integration test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

void main() => run(_testMain);

run(void Function() testMain) {}

void _testMain() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});
}
