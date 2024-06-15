import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/habit_tracker.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(
    MaterialApp(
      theme: ThemeData(
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(
              width: 1,
              color: Color.fromARGB(255, 53, 53, 53),
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(255, 81, 124, 255),
          unselectedItemColor: Color.fromARGB(255, 134, 134, 134),
          backgroundColor: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent.withAlpha(100),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 232, 232, 232),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: const IconThemeData(
              size: 24, color: Color.fromARGB(255, 232, 232, 232)),
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 232, 232, 232),
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 232, 232, 232),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: HabitTracker(),
    ),
  );
}
