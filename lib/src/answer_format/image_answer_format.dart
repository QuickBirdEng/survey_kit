import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/answer_format/answer_format.dart';

part 'image_answer_format.g.dart';

@JsonSerializable()
class ImageAnswerFormat implements AnswerFormat {
  final String? defaultValue;
  final String buttonText;
  final bool useGallery;
  final String? hintImage;
  final String? hintTitle;

  const ImageAnswerFormat({
    this.defaultValue,
    this.buttonText = 'Image: ',
    this.useGallery = true,
    this.hintImage,
    this.hintTitle,

  }) : super();

  factory ImageAnswerFormat.fromJson(Map<String, dynamic> json) =>
      _$ImageAnswerFormatFromJson(json);

  Map<String, dynamic> toJson() => _$ImageAnswerFormatToJson(this);
}
