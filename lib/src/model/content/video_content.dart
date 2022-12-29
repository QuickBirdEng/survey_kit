import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'video_content.g.dart';

@JsonSerializable()
class VideoContent extends Content {
  final String url;

  const VideoContent({
    required this.url,
    super.id,
  });

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);

  Map<String, dynamic> toJson() => _$VideoContentToJson(this);
}
