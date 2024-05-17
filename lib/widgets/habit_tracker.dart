import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() {
    return _HabitTrackerState();
  }
}

class _HabitTrackerState extends State<HabitTracker> {

  final List<Habit> _registeredHabits = [
    Habit(
      name: "Workout",
    ),
    Habit(
      name: "Feed Spruce",
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit Tracker'),
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
