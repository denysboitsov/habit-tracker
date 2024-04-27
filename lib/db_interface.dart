import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:habit_tracker/models/habit.dart';

class DB {
  var database;

  DB() {
    createDB();
  }

  Future<void> createDB() async {
    print("Creating DB.");
    database = await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'doggie_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute('''
          DELETE FROM habits,
          CREATE TABLE habits(id TEXT PRIMARY KEY, name TEXT),
          '''
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    await database.execute('''
          DELETE FROM habits
          '''
        );
    print("DB Created.");
  }

  Future<void> insertHabit(Habit habit) async {
    final db = await database;
    await db.insert(
      'habits',
      habit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Adding some to DB.");
  }

  Future<void> getAllHabits() async {
    final db = await database;
    final List<Habit> habits = [];

    final List<Map<String, Object?>> result = await db.query("habits");
    for (var row in result) {
      habits.add()
      print(row["id"]);
      print(row["name"]);
    }
  }

}