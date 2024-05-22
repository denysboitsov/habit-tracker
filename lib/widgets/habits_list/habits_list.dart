import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_item.dart';
import 'package:flutter/material.dart';

class HabitsList extends StatelessWidget {
  const HabitsList({super.key, required this.habits, required this.onRemoveHabit});

  final List<Habit> habits;
  final void Function(Habit habit) onRemoveHabit;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      childAspectRatio: (10 / 5),
      // Generate 100 widgets that display their index in the List.
      children: [
        ...habits.map((habit) => GestureDetector(
              onTap: () {
                onRemoveHabit(habit);
              },
              child: HabitsItem(habit),
            )),
      ],
    );
  }
}
