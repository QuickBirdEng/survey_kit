import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:survey_kit/survey_kit.dart';

Future<Task> getSampleTask() {
  var task = NavigableTask(
    id: TaskIdentifier(),
    steps: [
      InstructionStep(
        title: 'Welcome to the\nQuickBird Studios\nHealth Survey',
        text: 'Get ready for a bunch of super random questions!',
        buttonText: 'Let\'s go!',
      ),
      QuestionStep(
        title: 'Gas Value',
        answerFormat: MultipleDoubleAnswerFormat(multiDouble: [
          MultiDouble(
            text: 'Gasolina Comum',
            value: 5.60,
          ),
          MultiDouble(
            text: 'Gasolina Aditivada',
            value: 5.80,
          ),
          //   MultiDouble(
          //     text: 'Diesel S500',
          //     value: 5.80,
          //   ),
          //   MultiDouble(
          //     text: 'Diesel S10',
          //     value: 5.85,
          //   ),
          // ], defaultValues: [
          //   MultiDouble(
          //     text: 'Default',
          //     value: 0.0,
          //   ),
        ]),
        isOptional: false,
      ),
      CompletionStep(
        stepIdentifier: StepIdentifier(id: '321'),
        text: 'Thanks for taking the survey!',
        title: 'Done!',
        buttonText: 'Submit survey',
      ),
    ],
  );
  task.addNavigationRule(
    forTriggerStepIdentifier: task.steps[task.steps.length - 1].stepIdentifier,
    navigationRule: ConditionalNavigationRule(
      resultToStepIdentifierMapper: (input) {
        switch (input) {
          case "Yes":
            return task.steps[0].stepIdentifier;
          case "No":
            return task.steps[task.steps.length].stepIdentifier;
          default:
            return null;
        }
      },
    ),
  );
  return Future.value(task);
}

Future<Task> getJsonTask() async {
  final taskJson = await rootBundle.loadString('assets/example_json.json');
  final taskMap = json.decode(taskJson);

  return Task.fromJson(taskMap);
}
