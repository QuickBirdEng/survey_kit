import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'audio_content.g.dart';

@JsonSerializable()
class AudioContent extends Content {
  final String url;

  const AudioContent({
    required this.url,
    super.id,
  });

  factory AudioContent.fromJson(Map<String, dynamic> json) =>
      _$AudioContentFromJson(json);

  Map<String, dynamic> toJson() => _$AudioContentToJson(this);
}
