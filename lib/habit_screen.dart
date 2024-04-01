import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tile.dart';
import 'package:habit_tracker/data/habits.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() {
    return _HabitScreenState();
  }
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < habits.length / 2; i++)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width / 2 * 0.05),
                  child: HabitTile(name: habits[i * 2].name, isCompleted: habits[i * 2].isCompleted,),
                ),
                if (i * 2 + 1 < habits.length)
                  Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width / 2 * 0.05),
                    child: HabitTile(name: habits[i * 2 + 1].name, isCompleted: habits[i * 2].isCompleted,),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
