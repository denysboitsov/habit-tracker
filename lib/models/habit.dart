import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();


class Habit {
  Habit({
    this.endDate,
    required this.name,
    required this.isCompleted,
    required this.startDate,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  bool isCompleted;
  DateTime startDate;
  DateTime? endDate;
}