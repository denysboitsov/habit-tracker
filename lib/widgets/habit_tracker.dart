import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';
import 'package:habit_tracker/widgets/new_habit/new_habit.dart';
import 'package:habit_tracker/widgets/statistics/statistics.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;
import 'package:habit_tracker/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';

class HabitTracker extends StatefulWidget {
  const HabitTracker({super.key});

  @override
  State<HabitTracker> createState() {
    return _HabitTrackerState();
  }
}

class _HabitTrackerState extends State<HabitTracker> {
  void _openAddHabitOverlay() {
    showCupertinoModalPopup(
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
      DatabaseHelper().addHabit(habit.id, habit.name);
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
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: Colors.transparent,
        iconSize: 25,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.check_mark_circled_solid),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chart_bar),
            label: 'Statistics',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                border: Border.all(width: 0.0, style: BorderStyle.none),
                middle: Text(
                  'Today',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
                trailing: GestureDetector(
                  onTap: () {
                    _openAddHabitOverlay();
                  },
                  child: Icon(
                    CupertinoIcons.add,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: HabitsList(
                      onToggleHabit: _toggleHabit,
                      onRemoveHabit: _removeHabit,
                      fetchHabits: DatabaseHelper().getHabits,
                      onUpdateHabit: _updateHabit,
                    ),
                  ),
                ],
              ),
            );
          case 1:
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                border: Border.all(width: 0.0, style: BorderStyle.none),
                middle: Text(
                  'Statistics',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListView(
                            children: <Widget>[
                              StatsPage(),
                            ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

          default:
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                border: Border.all(width: 0.0, style: BorderStyle.none),
                middle: Text(
                  'Today',
                  style: CupertinoTheme.of(context)
                      .textTheme
                      .navLargeTitleTextStyle,
                ),
                trailing: GestureDetector(
                  onTap: () {
                    _openAddHabitOverlay();
                  },
                  child: Icon(
                    CupertinoIcons.add,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: HabitsList(
                      onToggleHabit: _toggleHabit,
                      onRemoveHabit: _removeHabit,
                      fetchHabits: DatabaseHelper().getHabits,
                      onUpdateHabit: _updateHabit,
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
