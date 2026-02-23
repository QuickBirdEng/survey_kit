import 'package:survey_kit/src/configuration/survey_kit_registry.dart';

import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/answer/date_answer_format.dart';
import 'package:survey_kit/src/model/answer/double_answer_format.dart';
import 'package:survey_kit/src/model/answer/integer_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_choice_auto_complete_answer_format.dart';
import 'package:survey_kit/src/model/answer/multiple_double_answer_format.dart';
import 'package:survey_kit/src/model/answer/scale_answer_format.dart';
import 'package:survey_kit/src/model/answer/single_choice_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_answer_format.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/answer/time_answer_format.dart';
import 'package:survey_kit/src/model/content/image_content.dart';
import 'package:survey_kit/src/model/content/markdown_content.dart';
import 'package:survey_kit/src/model/content/section_content.dart';
import 'package:survey_kit/src/model/content/styled_text_content.dart';
import 'package:survey_kit/src/model/content/text_content.dart';
import 'package:survey_kit/src/view/widget/answer/boolean_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/date_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/double_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/integer_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/multiple_choice_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/multiple_choice_auto_complete_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/multiple_double_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/scale_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/single_choice_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/text_answer_view.dart';
import 'package:survey_kit/src/view/widget/answer/time_answer_view.dart';
import 'package:survey_kit/src/view/widget/content/image_widget.dart';
import 'package:survey_kit/src/view/widget/content/markdown_widget.dart';
import 'package:survey_kit/src/view/widget/content/section_widget.dart';
import 'package:survey_kit/src/view/widget/content/styled_text_widget.dart';
import 'package:survey_kit/src/view/widget/content/text_widget.dart';

Map<Type, AnswerViewBuilder> getDefaultAnswerViewBuilders() {
  return {
    BooleanAnswerFormat: (answerFormat, step, result) => BooleanAnswerView(
          questionStep: step,
          result: result,
        ),
    DateAnswerFormat: (answerFormat, step, result) => DateAnswerView(
          questionStep: step,
          result: result,
        ),
    DoubleAnswerFormat: (answerFormat, step, result) => DoubleAnswerView(
          questionStep: step,
          result: result,
        ),
    IntegerAnswerFormat: (answerFormat, step, result) => IntegerAnswerView(
          questionStep: step,
          result: result,
        ),
    MultipleChoiceAnswerFormat<TextChoice>: (answerFormat, step, result) =>
        MultipleChoiceAnswerView(
          questionStep: step,
          result: result,
        ),
    MultipleChoiceAutoCompleteAnswerFormat: (answerFormat, step, result) =>
        MultipleChoiceAutoCompleteAnswerView(
          questionStep: step,
          result: result,
        ),
    MultipleDoubleAnswerFormat: (answerFormat, step, result) =>
        MultipleDoubleAnswerView(
          questionStep: step,
          result: result,
        ),
    ScaleAnswerFormat: (answerFormat, step, result) => ScaleAnswerView(
          questionStep: step,
          result: result,
        ),
    SingleChoiceAnswerFormat<TextChoice>: (answerFormat, step, result) =>
        SingleChoiceAnswerView(
          questionStep: step,
          result: result,
        ),
    TextAnswerFormat: (answerFormat, step, result) => TextAnswerView(
          questionStep: step,
          result: result,
        ),
    TimeAnswerFormat: (answerFormat, step, result) => TimeAnswerView(
          questionStep: step,
          result: result,
        ),
  };
}

Map<Type, ContentWidgetBuilder> getDefaultContentWidgetBuilders() {
  return {
    TextContent: (content) => TextWidget(
          textContent: content as TextContent,
        ),
    MarkdownContent: (content) => MarkdownWidget(
          markdownContent: content as MarkdownContent,
        ),
    ImageContent: (content) => ImageWidget(
          imageContent: content as ImageContent,
        ),
    SectionContent: (content) => SectionWidget(
          sectionContent: content as SectionContent,
        ),
    StyledTextContent: (content) => StyledTextWidget(
          content: content as StyledTextContent,
        ),
  };
}
