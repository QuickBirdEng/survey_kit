import 'package:json_annotation/json_annotation.dart';

import 'package:survey_kit/src/model/content/markdown_content.dart';
import 'package:survey_kit/src/model/content/text_content.dart';

/// Abstract base for all content types displayed on a [Step]. Content items
/// control what is rendered before the answer widget (text, images, markdown,
/// etc.). Use [Content.fromJson] for deserialization. Register custom types
/// with [registerFromJson].
@JsonSerializable()
abstract class Content {
  /// Optional identifier for this content item.
  final String? id;

  /// JSON type discriminator used during deserialization.
  @JsonKey(name: 'type')
  final String contentType;

  const Content({
    this.id,
    required this.contentType,
  });

  static final Map<String, Content Function(Map<String, dynamic>)> _converters =
      {
    'text': TextContent.fromJson,
    'markdown': MarkdownContent.fromJson,
  };

  /// Registers a custom [Content] subtype factory for JSON deserialization.
  static void registerFromJson(
    String type,
    Content Function(Map<String, dynamic>) factory,
  ) {
    _converters[type] = factory;
  }

  /// Deserializes a [Content] from [json]. Dispatches based on the 'type' field.
  factory Content.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    final converter = _converters[type];
    if (converter != null) {
      return converter(json);
    }

    throw Exception('Unknown type: $type');
  }

  /// Serializes this content to a JSON map.
  Map<String, dynamic> toJson();
}
