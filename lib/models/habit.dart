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
  }) : id = uuid.v4();

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  String get formattedStartDate {
    return formatter.format(startDate);
  }

  String get formattedEndDate {
    return formatter.format(endDate);
  }
}
