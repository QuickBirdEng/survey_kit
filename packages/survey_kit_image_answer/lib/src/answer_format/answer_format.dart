import 'package:survey_kit/survey_kit.dart';

abstract class ImageAnswerFormat extends AnswerFormat {
  factory ImageAnswerFormat.fromJson(Map<String, dynamic> json) {
    switch (json['type'] as String) {
      case 'file':
        return ImageAnswerFormat.fromJson(json);
      default:
        throw const AnswerFormatNotDefinedException();
    }
  }
  @override
  Map<String, dynamic> toJson();
}
