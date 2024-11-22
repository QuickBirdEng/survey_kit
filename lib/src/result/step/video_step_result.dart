import 'package:survey_kit/src/result/question_result.dart';
import 'package:survey_kit/src/steps/identifier/identifier.dart';

import 'package:json_annotation/json_annotation.dart';

part 'video_step_result.g.dart';

@JsonSerializable(explicitToJson: true)
class VideoStepResult extends QuestionResult<VideoResult> {
  VideoStepResult({
    required Identifier super.id,
    required super.startDate,
    required super.endDate,
    required VideoResult super.result,
  }) : super(
          valueIdentifier: id.id,
        );
  factory VideoStepResult.fromJson(Map<String, dynamic> json) =>
      _$VideoStepResultFromJson(json);

  Map<String, dynamic> toJson() => _$VideoStepResultToJson(this);

  @override
  List<Object?> get props => [id, startDate, endDate, valueIdentifier];
}

@JsonSerializable(explicitToJson: true)
class VideoResult {
  final Duration leftVideoAt;
  final DateTime stayedInVideo;

  factory VideoResult.fromJson(Map<String, dynamic> json) =>
      _$VideoResultFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResultToJson(this);


  const VideoResult({
    required this.leftVideoAt,
    required this.stayedInVideo,
  });
}
