import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/widgets/habit_tracker.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(
    const CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            color: CupertinoColors.white,
          ),
          navTitleTextStyle: TextStyle(
            color: CupertinoColors.white,
          ),
          navLargeTitleTextStyle: TextStyle(
            color: CupertinoColors.white,
            fontSize: 20,
          ),
        ),
        primaryColor: CupertinoColors.systemBlue,
        primaryContrastingColor: Color.fromARGB(255, 44, 44, 44),
        scaffoldBackgroundColor: CupertinoColors.black,
      ),
      home: HabitTracker(),
    ),
  );
}
