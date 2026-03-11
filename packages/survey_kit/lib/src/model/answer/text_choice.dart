import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'text_choice.g.dart';

/// A labeled option used in single- and multiple-choice answer formats.
/// Each choice has a display [text] and an optional [value] used for
/// logic/JSON, and a unique [id].
@immutable
@JsonSerializable()
class TextChoice {
  /// Unique identifier for this choice. Auto-generated with UUID if not
  /// provided.
  final String id;

  /// The human-readable label shown to the user.
  final String text;

  /// Optional machine-readable value associated with this choice.
  /// Used in [ConditionalNavigationRule] mappings.
  final String? value;

  TextChoice({
    String? id,
    required this.text,
    this.value,
  }) : id = id ?? const Uuid().v4();

  factory TextChoice.fromJson(Map<String, dynamic> json) =>
      _$TextChoiceFromJson(json);

  Map<String, dynamic> toJson() => _$TextChoiceToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TextChoice &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          value == other.value;

  @override
  int get hashCode => Object.hash(id, text, value);
}
