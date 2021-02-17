import 'package:uuid/uuid.dart';

class Identifier {
  String id;

  Identifier({String id}) {
    if (id == null) {
      id = Uuid().v4();
      return;
    }
    this.id = id;
  }
}
