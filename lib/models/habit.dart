import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();


class Habit {
  Habit({
    required this.name,
    required this.isCompleted,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  bool isCompleted;
}
