import 'package:json_annotation/json_annotation.dart';

part 'video_result.g.dart';

@JsonSerializable(explicitToJson: true)
class VideoResult {
  final Duration leftVideoAt;
  final DateTime stayedInVideo;

  const VideoResult({
    required this.leftVideoAt,
    required this.stayedInVideo,
  });

  factory VideoResult.fromJson(Map<String, dynamic> json) =>
      _$VideoResultFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResultToJson(this);
}
