import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/survey_kit_audio.dart';
import 'package:survey_kit_lottie/survey_kit_lottie.dart';
import 'package:survey_kit_video/survey_kit_video.dart';
import 'package:surveykit_example/survey_result_dialog.dart';

const jsonSurveyAsset = 'assets/json_survey.json';

class JsonSurveyPage extends StatefulWidget {
  const JsonSurveyPage({super.key});

  @override
  State<JsonSurveyPage> createState() => _JsonSurveyPageState();
}

class _JsonSurveyPageState extends State<JsonSurveyPage> {
  late Future<SurveyDefinition> _survey;

  @override
  void initState() {
    super.initState();
    _survey = _loadSurvey();
  }

  Future<SurveyDefinition> _loadSurvey() async {
    final raw = await rootBundle.loadString(jsonSurveyAsset);
    return SurveyDefinition.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  void _retry() {
    setState(() => _survey = _loadSurvey());
  }

  Future<void> _onResult(SurveyResult result) async {
    await showSurveyResultDialog(context, result, actionLabel: 'Close');
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SurveyDefinition>(
      future: _survey,
      builder: (context, snapshot) {
        final survey = snapshot.data;
        if (survey != null) {
          return SurveyKit(
            task: survey,
            registries: [SurveyKitAudio(), SurveyKitVideo(), SurveyKitLottie()],
            onResult: _onResult,
          );
        }
        if (snapshot.hasError) {
          return _LoadError(onRetry: _retry);
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}

class _LoadError extends StatelessWidget {
  const _LoadError({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Could not load the survey.'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
