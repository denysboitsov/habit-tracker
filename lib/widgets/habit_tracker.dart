import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';
import 'package:habit_tracker/widgets/new_habit/new_habit.dart';
import 'package:habit_tracker/widgets/statistics/statistics.dart';
import 'package:intl/intl.dart';
import 'package:habit_tracker/helpers/db_helper.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() {
    return _HabitTrackerState();
  }
}

class _HabitTrackerState extends State<HabitTracker> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openAddHabitOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewHabit(onAddHabit: _addHabit);
      },
    );
  }

  void _toggleHabit(Habit habit) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    setState(() {
      habit.isCompleted = !habit.isCompleted;
    });
    DatabaseHelper().toggleCompletion(habit.id, date, habit.isCompleted);
  }

  Future<void> _addHabit(Habit habit) async {
    setState(() {
      DatabaseHelper()
          .addHabit(habit.id, habit.name, habit.startDate, habit.endDate);
    });
  }

  Future<void> _updateHabit(Habit habit) async {
    setState(() {
      DatabaseHelper().updateHabit(habit.id, habit.name);
    });
  }

  Future<void> _removeHabit(Habit habit) async {
    await DatabaseHelper().removeHabit(habit.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HabitsList(
        onToggleHabit: _toggleHabit,
        onRemoveHabit: _removeHabit,
        fetchHabits: DatabaseHelper().getHabits,
        onUpdateHabit: _updateHabit,
      ),
      StatsPage(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        title: const Text('Today'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30.0,
            ),
            onPressed: () => _openAddHabitOverlay(),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.check_circle, size: 30,),
            icon: Icon(Icons.check_circle_outline, size: 30,),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bar_chart, size: 30,),
            icon: Icon(Icons.bar_chart_outlined, size: 30,),
            label: 'Stats',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
