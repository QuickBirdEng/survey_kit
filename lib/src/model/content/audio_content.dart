import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';
import 'package:survey_kit/src/view/widget/content/audio_widget.dart';

part 'audio_content.g.dart';

@JsonSerializable()
class AudioContent extends Content {
  static const type = 'audio';
  final String url;

  const AudioContent({
    required this.url,
    super.id,
  }) : super(contentType: type);

  factory AudioContent.fromJson(Map<String, dynamic> json) =>
      _$AudioContentFromJson(json);

  Map<String, dynamic> toJson() => _$AudioContentToJson(this);

  @override
  Widget createWidget() {
    return AudioWidget(audioContent: this);
  }
}
