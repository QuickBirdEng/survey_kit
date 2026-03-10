import 'package:collection/collection.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:survey_kit/src/configuration/survey_configuration.dart';
import 'package:survey_kit/src/configuration/survey_kit_default_registry.dart';
import 'package:survey_kit/src/configuration/survey_kit_plugin.dart';
import 'package:survey_kit/src/configuration/survey_kit_registry.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/model/result/survey_result.dart';
import 'package:survey_kit/src/model/step.dart';
import 'package:survey_kit/src/navigator/navigable_task_navigator.dart';
import 'package:survey_kit/src/navigator/task_navigator.dart';
import 'package:survey_kit/src/presenter/survey_event.dart';
import 'package:survey_kit/src/presenter/survey_state.dart';
import 'package:survey_kit/src/presenter/survey_state_provider.dart';
import 'package:survey_kit/src/task/survey_definition.dart';
import 'package:survey_kit/src/task/survey_flow.dart';
import 'package:survey_kit/src/view/widget/answer/answer_view.dart';
import 'package:survey_kit/src/widget/survey_app_bar.dart';
import 'package:survey_kit/src/widget/survey_kit_page_route_builder.dart';
import 'package:survey_kit/src/widget/survey_progress_configuration.dart';

typedef StepShell = Widget Function(
  Step step,
  Widget? answerWidget,
  BuildContext context,
);

class SurveyKit extends StatefulWidget {
  /// [SurveyDefinition] for the configuration of the survey.
  final SurveyDefinition task;

  /// Function which is called after the results are collected
  final Function(SurveyResult) onResult;

  /// [SurveyController] to override the navigation methods
  /// onNextStep, onBackStep, onCloseSurvey
  final SurveyController? surveyController;

  /// The appbar that is shown at the top
  final PreferredSizeWidget? appBar;

  // Changes the styling of the progressbar in the appbar
  final SurveyProgressConfiguration? surveyProgressbarConfiguration;

  /// Localizations for the survey
  final Map<String, String>? localizations;

  /// Step shell
  final StepShell? stepShell;

  /// Decoration which is applied to the survey container
  final BoxDecoration? decoration;

  final Color? backgroundColor;

  final Map<Type, AnswerViewBuilder>? answerViewBuilders;
  final Map<Type, ContentWidgetBuilder>? contentWidgetBuilders;
  final List<SurveyKitPlugin>? registries;

  const SurveyKit({
    super.key,
    required this.task,
    required this.onResult,
    this.surveyController,
    this.surveyProgressbarConfiguration,
    this.appBar,
    this.localizations,
    this.stepShell,
    this.decoration,
    this.backgroundColor,
    this.answerViewBuilders,
    this.contentWidgetBuilders,
    this.registries,
  });

  @override
  _SurveyKitState createState() => _SurveyKitState();
}

class _SurveyKitState extends State<SurveyKit> {
  late TaskNavigator _taskNavigator;
  late SurveyController _surveyController;
  late final GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    super.initState();
    _navigatorKey = GlobalKey<NavigatorState>();
    _surveyController = widget.surveyController ?? SurveyController();
    _surveyController.navigatorKey = _navigatorKey;
    _taskNavigator = _createTaskNavigator();
  }

  @override
  void didUpdateWidget(covariant SurveyKit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.surveyController != oldWidget.surveyController) {
      if (oldWidget.surveyController?.navigatorKey == _navigatorKey) {
        oldWidget.surveyController?.navigatorKey = null;
      }
      _surveyController = widget.surveyController ?? SurveyController();
      _surveyController.navigatorKey = _navigatorKey;
    }
    if (widget.task != oldWidget.task) {
      _taskNavigator = _createTaskNavigator();
    }
  }

  TaskNavigator _createTaskNavigator() {
    final task = widget.task;
    if (task is SurveyFlow) {
      return NavigableTaskNavigator(widget.task);
    }

    throw Exception(
      'Task must be SurveyFlow (legacy OrderedTask/NavigableTask are supported).',
    );
  }

  @override
  void dispose() {
    if (_surveyController.navigatorKey == _navigatorKey) {
      _surveyController.navigatorKey = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SurveyConfiguration(
      surveyProgressConfiguration: widget.surveyProgressbarConfiguration ??
          SurveyProgressConfiguration(),
      taskNavigator: _taskNavigator,
      surveyController: _surveyController,
      localizations: widget.localizations,
      padding: const EdgeInsets.all(14),
      child: SurveyStateProviderWidget(
        taskNavigator: _taskNavigator,
        onResult: widget.onResult,
        stepShell: widget.stepShell,
        navigatorKey: _navigatorKey,
        child: _buildSurveyPage(context),
      ),
    );
  }

  Widget _buildSurveyPage(BuildContext context) {
    if (widget.answerViewBuilders != null ||
        widget.contentWidgetBuilders != null ||
        widget.registries != null) {
      final answerViewBuilders =
          Map<Type, AnswerViewBuilder>.from(getDefaultAnswerViewBuilders());
      final contentWidgetBuilders = Map<Type, ContentWidgetBuilder>.from(
        getDefaultContentWidgetBuilders(),
      );

      if (widget.registries != null) {
        for (final registry in widget.registries!) {
          answerViewBuilders.addAll(registry.answerViewBuilders);
          contentWidgetBuilders.addAll(registry.contentWidgetBuilders);
        }
      }

      if (widget.answerViewBuilders != null) {
        answerViewBuilders.addAll(widget.answerViewBuilders!);
      }
      if (widget.contentWidgetBuilders != null) {
        contentWidgetBuilders.addAll(widget.contentWidgetBuilders!);
      }

      return SurveyKitRegistry(
        initialAnswerViewBuilders: answerViewBuilders,
        initialContentWidgetBuilders: contentWidgetBuilders,
        child: SurveyPage(
          backgroundColor: widget.backgroundColor,
          length: widget.task.steps.length,
          onResult: widget.onResult,
          appBar: widget.appBar,
          navigatorKey: _navigatorKey,
          decoration: widget.decoration,
        ),
      );
    }

    if (SurveyKitRegistry.of(context) == null) {
      return SurveyKitRegistry(
        initialAnswerViewBuilders: getDefaultAnswerViewBuilders(),
        initialContentWidgetBuilders: getDefaultContentWidgetBuilders(),
        child: SurveyPage(
          backgroundColor: widget.backgroundColor,
          length: widget.task.steps.length,
          onResult: widget.onResult,
          appBar: widget.appBar,
          navigatorKey: _navigatorKey,
          decoration: widget.decoration,
        ),
      );
    }

    return SurveyPage(
      backgroundColor: widget.backgroundColor,
      length: widget.task.steps.length,
      onResult: widget.onResult,
      appBar: widget.appBar,
      navigatorKey: _navigatorKey,
      decoration: widget.decoration,
    );
  }
}

class SurveyPage extends StatefulWidget {
  final int length;
  final Function(SurveyResult) onResult;
  final PreferredSizeWidget? appBar;
  final GlobalKey<NavigatorState> navigatorKey;
  final Decoration? decoration;
  final Color? backgroundColor;

  const SurveyPage({
    super.key,
    required this.length,
    required this.onResult,
    required this.navigatorKey,
    this.appBar,
    this.decoration,
    this.backgroundColor,
  });

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage>
    with SingleTickerProviderStateMixin {
  PresentingSurveyState? _initialRouteSnapshot;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => SurveyStateProvider.of(context).onEvent(
        StartSurvey(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar ?? const SurveyAppBar(),
      body: Container(
        decoration: widget.decoration,
        child: Navigator(
          key: widget.navigatorKey,
          onGenerateRoute: (settings) => SurveyKitPageRouteBuilder<Widget>(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(-0.08, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: secondaryAnimation,
                  curve: Curves.easeOutCubic,
                  reverseCurve: Curves.easeInCubic,
                ),
              ),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                    reverseCurve: Curves.easeInCubic,
                  ),
                ),
                child: child,
              ),
            ),
            pageBuilder: (_, __, ___) {
              final routeState = settings.arguments;
              PresentingSurveyState? currentState;

              if (routeState is PresentingSurveyState) {
                currentState = routeState;
              } else {
                final providerState = SurveyStateProvider.of(context).state;
                if (providerState is PresentingSurveyState) {
                  currentState = _initialRouteSnapshot ??= providerState;
                } else {
                  currentState = _initialRouteSnapshot;
                }
              }

              if (currentState == null) {
                return const SizedBox.shrink();
              }

              final presentingState = currentState;
              final step = presentingState.currentStep;
              return _SurveyView(
                id: step.id,
                createView: () => AnswerView(
                  answer: step.answerFormat,
                  step: step,
                  stepResult: presentingState.questionResults.firstWhereOrNull(
                    (element) => element.id == step.id,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SurveyView extends StatelessWidget {
  const _SurveyView({
    required this.id,
    required this.createView,
  });

  final String id;
  final Widget Function() createView;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey<String>(
        id,
      ),
      child: createView(),
    );
  }
}
