import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/habits_list/habits_item.dart';
import 'package:flutter/material.dart';

class HabitsList extends StatelessWidget {
  const HabitsList(
      {super.key, required this.onToggleHabit, required this.onRemoveHabit, required this.fetchHabits, required this.onUpdateHabit,});

  final void Function(Habit habit) onUpdateHabit;
  final void Function(Habit habit) onToggleHabit;
  final void Function(Habit habit) onRemoveHabit;
  final Future<List<Habit>> Function() fetchHabits;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Habit>>(
      future: fetchHabits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final habits = snapshot.data!;
          habits.sort((a, b) {
            if (!b.isCompleted) {
              return 1;
            }
            return -1;
          });
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: (10 / 5),
              children: [
                ...habits.map((habit) => HabitsItem(habit, onToggleHabit: onToggleHabit, onRemoveHabit: onRemoveHabit, onUpdateHabit: onUpdateHabit,)),
              ],
            ),
          );
        }
      },
    );
  }
}