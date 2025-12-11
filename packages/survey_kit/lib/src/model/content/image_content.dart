import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'image_content.g.dart';

@JsonSerializable()
class ImageContent extends Content {
  static const type = 'image';

  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const ImageContent({
    super.id,
    required this.url,
    this.fit,
    this.width,
    this.height,
  }) : super(contentType: type);

  factory ImageContent.fromJson(Map<String, dynamic> json) =>
      _$ImageContentFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImageContentToJson(this);
}
