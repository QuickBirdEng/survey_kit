import 'package:flutter/material.dart';

/// Is needed to make WillOnPopScope work with iOS swipe back gesture
class SurveyKitPageRouteBuilder<T> extends PageRoute<T> {
  SurveyKitPageRouteBuilder({
    super.settings,
    required this.pageBuilder,
    this.transitionsBuilder = _defaultTransitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.maintainState = true,
    super.fullscreenDialog,
  });

  final RoutePageBuilder pageBuilder;
  final RouteTransitionsBuilder transitionsBuilder;

  @override
  @protected
  bool get hasScopedWillPopCallback {
    return false;
  }

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel;

  @override
  final bool maintainState;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return pageBuilder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return transitionsBuilder(context, animation, secondaryAnimation, child);
  }
}

Widget _defaultTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return child;
}
