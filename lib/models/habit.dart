import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();


class Habit {
  Habit({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.isCompleted,
    String? id,
  }) : id = id ?? uuid.v4();

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  bool isCompleted;

  String get formattedStartDate {
    return formatter.format(startDate);
  }

  String get formattedEndDate {
    return formatter.format(endDate);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Habit && runtimeType == other.runtimeType && id == other.id;
}
