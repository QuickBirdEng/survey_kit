import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'identifier.g.dart';

@JsonSerializable()
class Identifier {
  final String id;

  Identifier({String? id}) : id = id ?? Uuid().v4();

  factory Identifier.fromJson(Map<String, dynamic> json) =>
      _$IdentifierFromJson(json);
  Map<String, dynamic> toJson() => _$IdentifierToJson(this);

  bool operator ==(o) => o is Identifier && o.id == id;
  int get hashCode => id.hashCode;
}
