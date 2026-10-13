import 'package:survey_kit/src/model/answer/boolean_answer_format.dart';
import 'package:survey_kit/src/model/answer/multi_double.dart';
import 'package:survey_kit/src/model/answer/text_choice.dart';
import 'package:survey_kit/src/model/result/step_result.dart';
import 'package:survey_kit/src/model/result/time_result.dart';

/// Converts a [StepResult.result] value to and from a JSON-safe
/// representation.
///
/// Each codec is identified by [type], which is written to the `resultType`
/// field of the serialized [StepResult] so that [StepResult.fromJson] can
/// restore the typed value. Register codecs for custom result types with
/// [StepResult.registerResultCodec].
class StepResultCodec {
  const StepResultCodec({
    required this.type,
    required this.canEncode,
    required this.encode,
    required this.decode,
  });

  /// Creates a codec for values of type [T].
  static StepResultCodec of<T extends Object>({
    required String type,
    required Object? Function(T value) encode,
    required T Function(Object? json) decode,
  }) => StepResultCodec(
    type: type,
    canEncode: (value) => value is T,
    encode: (value) => encode(value as T),
    decode: decode,
  );

  /// Discriminator written to the `resultType` JSON field.
  final String type;

  /// Whether this codec can serialize [value].
  final bool Function(Object value) canEncode;

  /// Converts [value] into a JSON-encodable object.
  final Object? Function(Object value) encode;

  /// Restores the typed value from its JSON representation.
  final Object? Function(Object? json) decode;

  static final List<StepResultCodec> _customCodecs = [];

  static final List<StepResultCodec> _builtInCodecs = [
    StepResultCodec.of<String>(
      type: 'string',
      encode: (value) => value,
      decode: (json) => json! as String,
    ),
    StepResultCodec.of<bool>(
      type: 'bool',
      encode: (value) => value,
      decode: (json) => json! as bool,
    ),
    StepResultCodec.of<int>(
      type: 'int',
      encode: (value) => value,
      decode: (json) => (json! as num).toInt(),
    ),
    StepResultCodec.of<double>(
      type: 'double',
      encode: (value) => value,
      decode: (json) => (json! as num).toDouble(),
    ),
    StepResultCodec.of<DateTime>(
      type: 'dateTime',
      encode: (value) => value.toIso8601String(),
      decode: (json) => DateTime.parse(json! as String),
    ),
    StepResultCodec.of<BooleanResult>(
      type: 'booleanResult',
      encode: (value) => value.name,
      decode: (json) => BooleanResult.values.byName(json! as String),
    ),
    StepResultCodec.of<TimeResult>(
      type: 'timeResult',
      encode: (value) => value.toJson(),
      decode: (json) => TimeResult.fromJson(_asMap(json)),
    ),
    StepResultCodec.of<TextChoice>(
      type: 'textChoice',
      encode: (value) => value.toJson(),
      decode: (json) => TextChoice.fromJson(_asMap(json)),
    ),
    StepResultCodec.of<MultiDouble>(
      type: 'multiDouble',
      encode: (value) => value.toJson(),
      decode: (json) => MultiDouble.fromJson(_asMap(json)),
    ),
    StepResultCodec.of<StepResult>(
      type: 'stepResult',
      encode: (value) => value.toJson(),
      decode: (json) => StepResult<dynamic>.fromJson(_asMap(json)),
    ),
    _listCodec<TextChoice>(
      type: 'textChoiceList',
      encode: (value) => value.toJson(),
      decode: (json) => TextChoice.fromJson(_asMap(json)),
    ),
    _listCodec<MultiDouble>(
      type: 'multiDoubleList',
      encode: (value) => value.toJson(),
      decode: (json) => MultiDouble.fromJson(_asMap(json)),
    ),
    _listCodec<StepResult>(
      type: 'stepResultList',
      encode: (value) => value.toJson(),
      decode: (json) => StepResult<dynamic>.fromJson(_asMap(json)),
    ),
  ];

  static StepResultCodec _listCodec<T extends Object>({
    required String type,
    required Object? Function(T value) encode,
    required T Function(Object? json) decode,
  }) => StepResultCodec(
    type: type,
    canEncode: (value) =>
        value is List<T> ||
        (value is List && value.isNotEmpty && value.every((e) => e is T)),
    encode: (value) =>
        (value as List).map((dynamic e) => encode(e as T)).toList(),
    decode: (json) => (json! as List).map<T>(decode).toList(),
  );

  static Map<String, dynamic> _asMap(Object? json) =>
      (json! as Map).cast<String, dynamic>();

  /// Registers [codec] with priority over the built-in codecs and any
  /// previously registered codec with the same [type].
  static void register(StepResultCodec codec) {
    _customCodecs
      ..removeWhere((existing) => existing.type == codec.type)
      ..insert(0, codec);
  }

  static Iterable<StepResultCodec> get _codecs =>
      _customCodecs.followedBy(_builtInCodecs);

  /// Encodes [value] into its JSON representation together with the codec
  /// [type] that produced it. Values without a matching codec are returned
  /// unchanged with a null type.
  static ({String? type, Object? value}) encodeValue(Object? value) {
    if (value == null) {
      return (type: null, value: null);
    }
    for (final codec in _codecs) {
      if (codec.canEncode(value)) {
        return (type: codec.type, value: codec.encode(value));
      }
    }
    return (type: null, value: value);
  }

  /// Decodes [json] with the codec registered for [type]. Returns [json]
  /// unchanged when [type] is null or unknown.
  static Object? decodeValue(String? type, Object? json) {
    if (type == null || json == null) {
      return json;
    }
    for (final codec in _codecs) {
      if (codec.type == type) {
        return codec.decode(json);
      }
    }
    return json;
  }
}
