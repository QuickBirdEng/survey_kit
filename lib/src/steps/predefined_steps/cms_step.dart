import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:survey_kit/src/steps/cms_steps/cms_content_step.dart';
import 'package:survey_kit/src/views/cms_step_view.dart';

@JsonSerializable()
@immutable
class CMSStep {
  final List<Content> contextSteps;
  const CMSStep({
    required this.contextSteps,
  });

  Widget createView() {
    return CMSStepView(
      cmsStep: this,
    );
  }

  @override
  bool operator ==(Object other) => super == other && other is CMSStep;

  @override
  int get hashCode => super.hashCode ^ contextSteps.hashCode;
}
