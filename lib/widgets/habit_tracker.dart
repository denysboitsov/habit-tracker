import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';
import 'package:habit_tracker/widgets/new_habit/new_habit.dart';
import 'package:habit_tracker/widgets/statistics/statistics.dart';
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
    HapticFeedback.lightImpact();
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

  Future<void> _addHabit(Habit habit) async {
    setState(() {
      DatabaseHelper()
          .addHabit(habit.id, habit.name, habit.startDate, habit.endDate);
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
        onRemoveHabit: _removeHabit,
        fetchHabits: DatabaseHelper().getHabits,
      ),
      const StatsPage(),
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        title: _selectedIndex == 0
            ? const Text('Today')
            : const Text('Statistics'),
        actions: _selectedIndex == 0
            ? <Widget>[
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.add,
                    size: 30.0,
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    _openAddHabitOverlay();
                  },
                ),
              ]
            : [],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: const Color.fromARGB(255, 134, 134, 134),
              backgroundColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.check_circle,
                    size: 30,
                  ),
                  icon: Icon(
                    Icons.check_circle_outline,
                    size: 30,
                  ),
                  label: 'Today',
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.bar_chart,
                    size: 30,
                  ),
                  icon: Icon(
                    Icons.bar_chart_outlined,
                    size: 30,
                  ),
                  label: 'Stats',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
