import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';
import 'package:habit_tracker/widgets/new_habit/new_habit.dart';

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
      builder: (ctx) => NewHabit(),
    );
  }

  final List<Habit> _registeredHabits = [
    Habit(
      name: "Workout",
    ),
    Habit(
      name: "Feed Spruce",
    ),
    Habit(
      name: "Feed Maggy",
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
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
            child: HabitsList(habits: _registeredHabits),
          ),
        ],
      ),
    );
  }
}
