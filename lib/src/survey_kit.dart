import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:provider/provider.dart';
import 'package:survey_kit/src/view/widget/answer/answer_view.dart';
import 'package:survey_kit/survey_kit.dart';

typedef StepShell = Widget Function(
  Step step,
  Widget? answerWidget,
  BuildContext context,
);

class SurveyKit extends StatefulWidget {
  /// [Task] for the configuraton of the survey
  final Task task;

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

  /// Widget which is shown while the survey is loading (isLoading = true)
  final Widget? loadingState;

  final bool keepLastStateAlive;

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
    this.loadingState,
    this.keepLastStateAlive = false,
  });

  @override
  _SurveyKitState createState() => _SurveyKitState();
}

class _SurveyKitState extends State<SurveyKit> {
  late TaskNavigator _taskNavigator;
  late final GlobalKey<NavigatorState> _navigatorKey;

  @override
  void initState() {
    super.initState();
    _taskNavigator = _createTaskNavigator();
    _navigatorKey = GlobalKey<NavigatorState>();
  }

  TaskNavigator _createTaskNavigator() {
    final task = widget.task;
    if (task is OrderedTask) {
      return OrderedTaskNavigator(widget.task);
    }
    if (task is NavigableTask) {
      return NavigableTaskNavigator(widget.task);
    }

    throw Exception('Task must be either OrderedTask or NavigableTask');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SurveyConfiguration(
      surveyProgressConfiguration: widget.surveyProgressbarConfiguration ??
          SurveyProgressConfiguration(),
      taskNavigator: _taskNavigator,
      surveyController: widget.surveyController ?? SurveyController(),
      localizations: widget.localizations,
      padding: const EdgeInsets.all(14),
      child: ChangeNotifierProvider<SurveyStateProvider>(
        create: (_) => SurveyStateProvider(
          taskNavigator: _taskNavigator,
          onResult: widget.onResult,
          stepShell: widget.stepShell,
          navigatorKey: _navigatorKey,
        ),
        builder: (context, child) {
          return SurveyPage(
            length: widget.task.steps.length,
            onResult: widget.onResult,
            appBar: widget.appBar,
            navigatorKey: _navigatorKey,
            decoration: widget.decoration,
            loadingState: widget.loadingState,
            keepLastStateAlive: widget.keepLastStateAlive,
          );
        },
      ),
    );
  }
}

class SurveyPage extends StatefulWidget {
  final int length;
  final Function(SurveyResult) onResult;
  final PreferredSizeWidget? appBar;
  final GlobalKey<NavigatorState> navigatorKey;
  final BoxDecoration? decoration;
  final Widget? loadingState;
  final bool keepLastStateAlive;

  const SurveyPage({
    super.key,
    required this.length,
    required this.onResult,
    required this.navigatorKey,
    this.appBar,
    this.decoration,
    this.loadingState,
    this.keepLastStateAlive = false,
  });

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Provider.of<SurveyStateProvider>(context, listen: false).onEvent(
        StartSurvey(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar ?? const SurveyAppBar(),
      body: Navigator(
        key: widget.navigatorKey,
        onGenerateRoute: (settings) => CupertinoPageRoute<Widget>(
          builder: (_) {
            final arg = settings.arguments;
            if (arg == null || arg is! SurveyState) {
              return widget.loadingState ??
                  const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
            }
            final state = settings.arguments! as SurveyState;

            final step = state.currentStep;
            return _SurveyView(
              key: ValueKey<String>(
                step!.id,
              ),
              id: step.id,
              decoration: widget.decoration,
              createView: () => AnswerView(
                answer: step.answerFormat,
                step: step,
                stepResult: state.questionResults.firstWhereOrNull(
                  (element) => element.id == step.id,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SurveyView extends StatelessWidget {
  const _SurveyView({
    super.key,
    required this.id,
    required this.createView,
    this.decoration,
  });

  final String id;
  final Widget Function() createView;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: decoration ??
          const BoxDecoration(
            color: Colors.white,
          ),
      child: createView(),
    );
  }
}
