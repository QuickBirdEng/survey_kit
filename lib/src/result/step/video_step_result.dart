import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';
import 'package:survey_kit/survey_kit.dart';

class VideoStepResult extends QuestionResult<VideoResult> {
  VideoStepResult({
    required Identifier id,
    required DateTime startDate,
    required DateTime endDate,
    required VideoResult videoResult,
  }) : super(
          id: id,
          startDate: startDate,
          endDate: endDate,
          valueIdentifier: id.id,
          result: videoResult,
        );
}

class VideoResult {
  final DateTime leftVideoAt;
  final DateTime stayedInVideo;

  const VideoResult({
    required this.leftVideoAt,
    required this.stayedInVideo,
  });
}
