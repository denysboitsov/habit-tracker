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
      DatabaseHelper().addHabit(habit.id, habit.name, habit.startDate, habit.endDate);
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
      appBar: AppBar(
        title: Text('Habit Tracker'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openAddHabitOverlay(),
          ),
        ],
      ),
      //body: Row(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
    // return CupertinoTabScaffold(
    //   tabBar: CupertinoTabBar(
    //     backgroundColor: Colors.transparent,
    //     iconSize: 25,
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.check_mark_circled_solid),
    //         label: 'Today',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.chart_bar),
    //         label: 'Statistics',
    //       ),
    //     ],
    //   ),
    //   tabBuilder: (context, index) {
    //     switch (index) {
    //       case 0:
    //         print("lil");
    //         return CupertinoPageScaffold(
    //           navigationBar: CupertinoNavigationBar(
    //             backgroundColor: Colors.transparent,
    //             border: Border.all(width: 0.0, style: BorderStyle.none),
    //             middle: Text(
    //               'Today',
    //               style: CupertinoTheme.of(context)
    //                   .textTheme
    //                   .navLargeTitleTextStyle,
    //             ),
    //             trailing: GestureDetector(
    //               onTap: () {
    //                 _openAddHabitOverlay();
    //               },
    //               child: const Icon(
    //                 CupertinoIcons.add,
    //                 color: CupertinoColors.white,
    //               ),
    //             ),
    //           ),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: HabitsList(
    //                   onToggleHabit: _toggleHabit,
    //                   onRemoveHabit: _removeHabit,
    //                   fetchHabits: DatabaseHelper().getHabits,
    //                   onUpdateHabit: _updateHabit,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       case 1:
    //         print("lol");
    //         return CupertinoPageScaffold(
    //           navigationBar: CupertinoNavigationBar(
    //             backgroundColor: Colors.transparent,
    //             border: Border.all(width: 0.0, style: BorderStyle.none),
    //             middle: Text(
    //               'Statistics',
    //               style: CupertinoTheme.of(context)
    //                   .textTheme
    //                   .navLargeTitleTextStyle,
    //             ),
    //           ),
    //           child: SafeArea(
    //             child: Column(
    //               children: [
    //                 Expanded(
    //                   child: Padding(
    //                     padding: const EdgeInsets.all(4.0),
    //                     child: ListView(
    //                         children: const <Widget>[
    //                           StatsPage(),
    //                         ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );

    //       default:
    //         return CupertinoPageScaffold(
    //           navigationBar: CupertinoNavigationBar(
    //             backgroundColor: Colors.transparent,
    //             border: Border.all(width: 0.0, style: BorderStyle.none),
    //             middle: Text(
    //               'Today',
    //               style: CupertinoTheme.of(context)
    //                   .textTheme
    //                   .navLargeTitleTextStyle,
    //             ),
    //             trailing: GestureDetector(
    //               onTap: () {
    //                 _openAddHabitOverlay();
    //               },
    //               child: const Icon(
    //                 CupertinoIcons.add,
    //                 color: CupertinoColors.white,
    //               ),
    //             ),
    //           ),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: HabitsList(
    //                   onToggleHabit: _toggleHabit,
    //                   onRemoveHabit: _removeHabit,
    //                   fetchHabits: DatabaseHelper().getHabits,
    //                   onUpdateHabit: _updateHabit,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //     }
    //   },
    // );
  }
}
