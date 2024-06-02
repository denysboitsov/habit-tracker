
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_list.dart';
import 'package:habit_tracker/widgets/new_habit/new_habit.dart';
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
        // return Container(
        //   decoration: BoxDecoration(
        //     color: CupertinoColors.systemBackground.resolveFrom(context),
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(20),
        //       topRight: Radius.circular(20),
        //     ),
        //   ),
        //   padding: EdgeInsets.only(
        //     bottom: MediaQuery.of(context).viewInsets.bottom,
        //   ),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //             child: CupertinoButton(
        //               child: Text('Cancel'),
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //           ),
        //           Container(
        //             child: Text(
        //               "Add Habit",
        //               style: CupertinoTheme.of(context)
        //                   .textTheme
        //                   .navTitleTextStyle,
        //             ),
        //           ),
        //           Container(
        //             child: CupertinoButton(
        //               child: Text('Save'),
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //           ),
        //         ],
        //       ),
        //       SafeArea(
        //         child: Column(
        //           children: [
        //             Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 20),
        //               child: CupertinoTextField(
        //                 placeholder: 'Enter habit name',
        //                 padding: EdgeInsets.all(16.0),
        //               ),
        //             ),
        //             SizedBox(height: 100.0),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
      //isScrollControlled: true,
      // builder: (ctx) => NewHabit(
      //   onAddHabit: _addHabit,
      // ),
    );
  }

  void _toggleHabit(Habit habit) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    setState(() {
      habit.isCompleted = !habit.isCompleted;
    });
    DatabaseHelper().toggleCompletion(habit.id, date, habit.isCompleted);
    // ScaffoldMessenger.of(context).clearSnackBars();
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     duration: const Duration(seconds: 5),
    //     content: habit.isCompleted
    //         ? Text("Habit checked.")
    //         : Text("Habit unchecked."),
    //     action: SnackBarAction(
    //       label: 'Undo',
    //       onPressed: () {
    //         setState(() {
    //           habit.isCompleted = !habit.isCompleted;
    //         });
    //         DatabaseHelper()
    //             .toggleCompletion(habit.id, date, habit.isCompleted);
    //       },
    //     ),
    //   ),
    // );
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
    // cron.schedule(Schedule.parse('* * * * *'), () async {
    //   print("test");
    //   setState(() {});
    // });
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Today'),
        trailing: GestureDetector(
          onTap: () {
            _openAddHabitOverlay();
          },
          child: Icon(
            CupertinoIcons.add,
            color: CupertinoColors.black,
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
}
