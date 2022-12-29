import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/model/content/content.dart';

part 'lottie_content.g.dart';

@JsonSerializable()
class LottieContent extends Content {
  final String asset;
  final bool repeat;

  const LottieContent({
    required this.asset,
    this.repeat = false,
    super.id,
  });

  factory LottieContent.fromJson(Map<String, dynamic> json) =>
      _$LottieContentFromJson(json);

  Map<String, dynamic> toJson() => _$LottieContentToJson(this);
}
