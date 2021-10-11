import 'package:flutter/widgets.dart';

class AppBarConfiguration {
  final Widget? leading;
  final bool? canBack;
  final bool? showProgress;
  final Widget? trailing;

  const AppBarConfiguration({
    required this.canBack,
    required this.showProgress,
    this.leading,
    this.trailing,
  });
}
