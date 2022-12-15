import 'package:flutter/material.dart';
import 'package:survey_kit/src/steps/predefined_steps/cms_step.dart';

class CMSStepView extends StatelessWidget {
  final CMSStep cmsStep;
  final _startDate = DateTime.now();

  CMSStepView({
    super.key,
    required this.cmsStep,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...cmsStep.contextSteps
            .map(
              (e) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: e.createView(),
              ),
            )
            .toList(),
      ],
    );
  }
}
