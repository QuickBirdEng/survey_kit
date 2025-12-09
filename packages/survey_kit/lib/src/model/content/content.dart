import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:survey_kit/src/model/content/markdown_content.dart';
import 'package:survey_kit/src/model/content/text_content.dart';

@JsonSerializable()
abstract class Content {
  final String? id;
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

  static void registerFromJson(
    String type,
    Content Function(Map<String, dynamic>) factory,
  ) {
    _converters[type] = factory;
  }

  factory Content.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    assert(type != null, 'type is required');

    final converter = _converters[type];
    if (converter != null) {
      return converter(json);
    }

    throw Exception('Unknown type: $type');
  }

  Widget createWidget();

  Map<String, dynamic> toJson();
}
