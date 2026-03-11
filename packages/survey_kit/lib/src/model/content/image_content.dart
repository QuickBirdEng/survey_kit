import 'package:flutter/painting.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'image_content.g.dart';

/// Content that displays an image loaded from a URL.
/// The JSON type identifier is `'image'`.
@JsonSerializable()
class ImageContent extends Content {
  static const type = 'image';

  /// The URL of the image to display.
  final String url;

  /// How the image should be inscribed into the available space.
  final BoxFit? fit;

  /// Optional fixed width in logical pixels.
  final double? width;

  /// Optional fixed height in logical pixels.
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
