import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';
import 'package:habit_tracker/widgets/new_habit/new_habit.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() {
    return _HabitTrackerState();
  }
}

class _HabitTrackerState extends State<HabitTracker> {
  void _openAddHabitOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewHabit(
        onAddHabit: _addHabit,
      ),
    );
  }

  void _removeHabit(Habit habit) {
    final habitIndex = _registeredHabits.indexOf(habit);
    setState(() {
      _registeredHabits.remove(habit);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Habit deleted"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredHabits.insert(habitIndex, habit);
            });
          },
        ),
      ),
    );
  }

  Future<void> _addHabit(Habit habit) async {
    setState(() {
      _registeredHabits.add(habit);
    });
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      //path.join(dbPath, 'habits.db'),
      '/Users/denysartiukhov/Desktop/flutter_projects/habit-tracker/habits.db',
      onCreate: (db, version) {
        return db.execute("CREATE TABLE Habits (HabitID TEXT PRIMARY KEY, HabitName TEXT NOT NULL, Description TEXT, CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP);");
      },
      version: 1,
    );
    db.insert('habits', {
      'HabitID': habit.id,
      'HabitName': habit.name,
      'Description': "",
    });
  }

  final List<Habit> _registeredHabits = [
    Habit(
      name: "Workout",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    ),
    Habit(
      name: "Feed Spruce",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    ),
    Habit(
      name: "Feed Maggy",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // cron.schedule(Schedule.parse('* * * * *'), () async {
    //   print("test");
    //   setState(() {});
    // });
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
        actions: [
          IconButton(onPressed: _openAddHabitOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: HabitsList(
              habits: _registeredHabits,
              onRemoveHabit: _removeHabit,
            ),
          ),
        ],
      ),
    );
  }
}
