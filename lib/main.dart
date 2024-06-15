import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/habit_tracker.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(
    MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: HabitTracker(),
    ),
  );
}
