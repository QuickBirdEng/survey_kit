import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_audio/audio_widget.dart';

part 'audio_content.g.dart';

@JsonSerializable()
class AudioContent extends Content {
  static const type = 'audio';
  final String url;
  final String? title;
  final String? subtitle;
  final String? externalLink;

  const AudioContent({
    required this.url,
    super.id,
    this.title,
    this.subtitle,
    this.externalLink,
  }) : super(contentType: type);

  factory AudioContent.fromJson(Map<String, dynamic> json) =>
      _$AudioContentFromJson(json);

  Map<String, dynamic> toJson() => _$AudioContentToJson(this);

  @override
  Widget createWidget() {
    return AudioWidget(audioContent: this);
  }
}
