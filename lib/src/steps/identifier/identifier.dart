import 'package:uuid/uuid.dart';

class Identifier {
  final String id;

  Identifier({String? id}) : id = id ?? Uuid().v4();
}
