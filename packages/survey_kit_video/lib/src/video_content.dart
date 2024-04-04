import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:survey_kit_video/src/video_widget.dart';

part 'video_content.g.dart';

@JsonSerializable()
class VideoContent extends Content {
  static const type = 'video';

  final String url;
  final bool autoPlay;
  final bool loop;
  final double? width;
  final double? height;
  final String? title;
  final String? subtitle;
  final String? externalLink;

  const VideoContent({
    required this.url,
    super.id,
    this.autoPlay = false,
    this.loop = false,
    this.width,
    this.height,
    this.title,
    this.subtitle,
    this.externalLink,
  }) : super(contentType: type);

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);

  Map<String, dynamic> toJson() => _$VideoContentToJson(this);

  @override
  Widget createWidget() {
    return VideoWidget(videoContent: this);
  }
}
