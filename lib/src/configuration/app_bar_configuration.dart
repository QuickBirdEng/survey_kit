import 'package:flutter/widgets.dart';

class AppBarConfiguration {
  final Widget? leading;
  final bool? canBack;
  final bool? showProgress;
  final Widget? trailing;
  final bool? showCancelButton;

  const AppBarConfiguration({
    required this.canBack,
    required this.showProgress,
    this.showCancelButton = true,
    this.leading,
    this.trailing,
  });
}
