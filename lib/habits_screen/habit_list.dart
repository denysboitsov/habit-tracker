import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habits.dart';
import 'package:habit_tracker/habits_screen/habit_tile.dart';

class HabitList extends StatefulWidget {
  const HabitList({super.key});

  @override
  State<HabitList> createState() {
    return _HabitListState();
  }
}

class _HabitListState extends State<HabitList> {
  final double tileWidth = 0.47;
  refresh() {
    setState(() {
      habits.sort((a, b) =>
          a.isCompleted.toString().compareTo(b.isCompleted.toString()));
    });
  }
  @override
  Widget build(context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < habits.length / 2; i++)
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width *
                              ((0.5 - tileWidth) / 2)),
                      child: HabitTile(
                        habit: habits[i * 2],
                        notifyParent: refresh,
                        tileWidth: tileWidth,
                      ),
                    ),
                    if (i * 2 + 1 < habits.length)
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width *
                                ((0.5 - tileWidth) / 2)),
                        child: HabitTile(
                          habit: habits[i * 2 + 1],
                          notifyParent: refresh,
                          tileWidth: tileWidth,
                        ),
                      ),
                  ],
                ),
            ],
        ),
      ),
    );
  }
}