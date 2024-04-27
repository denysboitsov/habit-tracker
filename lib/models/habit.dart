import 'package:uuid/uuid.dart';

class Habit {
  var id;

  Habit(this.name) {
    id = Uuid().v1();
  }
  
  final String name;
  bool isCompleted = false;

  void setIsCompleted(isCompleted) {
    this.isCompleted = isCompleted;
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}