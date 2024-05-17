import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_item.dart';
import 'package:flutter/material.dart';

class HabitsList extends StatelessWidget {
  const HabitsList({super.key, required this.habits});

  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: habits.length,
      itemBuilder: (ctx, index) => HabitsItem(habits[index]),
    );
  }
}
