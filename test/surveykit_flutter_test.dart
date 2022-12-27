// import 'package:flutter/material.dart' hide Step;
// import 'package:flutter_test/flutter_test.dart';
// import 'package:survey_kit/survey_kit.dart';
//ToDO FIXME
// void main() {
//   testWidgets('survey_kit click through three steps',
//       (WidgetTester tester) async {
//     final surveyWidget = MaterialApp(
//       home: Scaffold(
//         body: SurveyKit(
//           task: OrderedTask(
//             id: '1',
//             steps: [
//               Step(
//                 title: 'Welcome to the\nQuickBird Studios\nHealth Survey',
//                 text: 'Get ready for a bunch of super random questions!',
//               ),
//               Step(
//                 title: 'How old are you?',
//                 answerFormat: const IntegerAnswerFormat(
//                   defaultValue: 25,
//                   hint: 'Please enter your age',
//                 ),
//               ),
//               CompletionStep(
//                 stepIdentifier: StepIdentifier(id: '321'),
//                 text: 'Thanks for taking the survey, we will contact you soon!',
//                 title: 'Done!',
//                 buttonText: 'Submit survey',
//               ),
//             ],
//           ),
//           onResult: (result) {
//             expect(result.finishReason, FinishReason.completed);
//           },
//         ),
//       ),
//     );

//     await tester.pumpWidget(surveyWidget);
//     await tester.pumpAndSettle();

//     final introButton = find.text("Let's go!".toUpperCase());
//     expect(introButton, findsOneWidget);
//     await tester.tap(introButton);

//     await tester.pumpAndSettle();
//     final textField = find.byType(TextField);
//     await tester.enterText(textField, '20');
//     await tester.pumpAndSettle();
//     final questionButton = find.text('Next'.toUpperCase());
//     expect(questionButton, findsOneWidget);
//     await tester.tap(questionButton);

//     await tester.pumpAndSettle();
//     final completeButtom = find.text('Submit survey'.toUpperCase());
//     expect(completeButtom, findsOneWidget);
//     await tester.tap(completeButtom);
//   });
// }
