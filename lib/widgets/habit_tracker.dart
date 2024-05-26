import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';
import 'package:habit_tracker/widgets/new_habit/new_habit.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:habit_tracker/helpers/db_helper.dart';

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
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)));
    final habitIndex = _registeredHabits.indexOf(habit);
    setState(() {
      habit.isCompleted = !habit.isCompleted;
    });
    DatabaseHelper().toggleCompletion(habit.id, date, habit.isCompleted);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: habit.isCompleted ? Text("Habit checked.") : Text("Habit unchecked."),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              habit.isCompleted = !habit.isCompleted;
            });
            DatabaseHelper().toggleCompletion(habit.id, date, habit.isCompleted);
          },
        ),
      ),
    );
  }

  Future<void> _addHabit(Habit habit) async {
    setState(() {
      _registeredHabits.add(habit);
      DatabaseHelper().addHabit(habit.id, habit.name);
    });
  }

  final List<Habit> _registeredHabits = [
    Habit(
      name: "Workout",
      isCompleted: false,
    ),
    Habit(
      name: "Feed Spruce",
      isCompleted: false,
    ),
    Habit(
      name: "Feed Maggy",
      isCompleted: false,
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
              onRemoveHabit: _removeHabit,
              fetchHabits: DatabaseHelper().getHabits,
            ),
          ),
        ],
      ),
    );
  }
}
