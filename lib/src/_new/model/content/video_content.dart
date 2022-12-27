import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/_new/model/content/content.dart';

part 'video_content.g.dart';

@JsonSerializable()
class VideoContent extends Content {
  final String url;

  const VideoContent({
    required super.id,
    required this.url,
  });

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);

  Map<String, dynamic> toJson() => _$VideoContentToJson(this);
}
