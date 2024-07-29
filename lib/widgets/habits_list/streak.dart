import 'package:flutter/material.dart';
import 'package:habit_tracker/helpers/db_helper.dart';
import 'package:habit_tracker/models/completion.dart';
import 'package:habit_tracker/models/habit.dart';

class Streak extends StatelessWidget {
  const Streak({
    super.key,
    required this.habit,
  });

  final Habit habit;

  static int calculateCurrentStreak(List<Completion>? completions) {
    if (completions == null) {
      return 0;
    }
    if (completions.isEmpty) {
      return 0;
    }

    completions.sort((a, b) => b.completionDate.compareTo(a.completionDate));

    if (completions[0].isCompleted == false) {
      return 0;
    }

    int currentStreak = 1;

    for (int i = 1; i < completions.length; i++) {
      if (completions[i].isCompleted &&
          completions[i - 1].isCompleted &&
          i != completions.length - 1) {
        currentStreak++;
      } else {
        break;
      }
    }

    return currentStreak;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Completion>>(
      future: DatabaseHelper()
          .getCompletions(habit, habit.startDate, DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Row();
        } else if (snapshot.hasError) {
          return const Row();
        } else {
          final completions = snapshot.data;
          final streak = calculateCurrentStreak(completions);
          return streak > 1
              ? Row(
                  children: [
                    Icon(
                      Icons.bolt,
                      color: habit.isCompleted ? Color.fromARGB(255, 177, 0, 1) : Colors.black,
                      size: 17,
                    ),
                    Text(
                      streak.toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: habit.isCompleted? Color.fromARGB(255, 177, 0, 1) : Colors.black),
                    ),
                  ],
                )
              : const Row();
        }
      },
    );
  }
}
