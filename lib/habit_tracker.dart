import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_screen.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() {
    return _HabitTrackerState();
  }
}

class _HabitTrackerState extends State<HabitTracker> {
  @override
  Widget build(context) {
    Widget screenWidget = HabitScreen();

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
