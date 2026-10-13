import 'package:json_annotation/json_annotation.dart';

import 'package:survey_kit/src/model/content/image_content.dart';
import 'package:survey_kit/src/model/content/markdown_content.dart';
import 'package:survey_kit/src/model/content/section_content.dart';
import 'package:survey_kit/src/model/content/styled_text_content.dart';
import 'package:survey_kit/src/model/content/text_content.dart';

/// Abstract base for all content types displayed on a [Step]. Content items
/// control what is rendered before the answer widget (text, images, markdown,
/// etc.). Use [Content.fromJson] for deserialization. Register custom types
/// with [registerFromJson].
abstract class Content {
  /// Optional identifier for this content item.
  final String? id;

  /// JSON type discriminator used during deserialization.
  @JsonKey(name: 'type')
  final String contentType;

  const Content({this.id, required this.contentType});

  static final Map<String, Content Function(Map<String, dynamic>)> _converters =
      {
        TextContent.type: TextContent.fromJson,
        MarkdownContent.type: MarkdownContent.fromJson,
        ImageContent.type: ImageContent.fromJson,
        SectionContent.type: SectionContent.fromJson,
        StyledTextContent.type: StyledTextContent.fromJson,
      };

  /// Registers a custom [Content] subtype factory for JSON deserialization.
  static void registerFromJson(
    String type,
    Content Function(Map<String, dynamic>) factory,
  ) {
    _converters[type] = factory;
  }

  /// Deserializes a [Content] from [json]. Dispatches based on the 'type'
  /// field. Throws a [FormatException] if the type is missing or unknown.
  factory Content.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    if (type == null) {
      throw FormatException('Content JSON is missing the "type" field.', json);
    }

    final converter = _converters[type];
    if (converter == null) {
      throw FormatException(
        'Unknown content type "$type". Register it with '
        'Content.registerFromJson.',
        json,
      );
    }
    return converter(json);
  }

  /// Serializes this content to a JSON map.
  Map<String, dynamic> toJson();
}
