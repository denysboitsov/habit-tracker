import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();


class Completion {
  Completion({
    required this.name,
    required this.completionDate,
    required this.isCompleted,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  final DateTime completionDate;
  bool isCompleted;
}
