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

  void _onEditHabit(context, Habit habit) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final result = showMenu(
        context: context,
        position: RelativeRect.fromRect(
          Rect.fromPoints(
            Offset(0, 0), // Offset from the top-left corner
            Offset(overlay.size.width, overlay.size.height),
          ),
          Offset.zero & overlay.size,),
        items: [
          const PopupMenuItem<String>(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
          const PopupMenuItem<String>(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Habit>>(
      future: fetchHabits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
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
          return GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this produces 2 rows.
            crossAxisCount: 2,
            childAspectRatio: (10 / 5),
            // Generate 100 widgets that display their index in the List.
            children: [
              ...habits.map((habit) => HabitsItem(habit, onToggleHabit: onToggleHabit, onRemoveHabit: onRemoveHabit, onUpdateHabit: onUpdateHabit,)),
            ],
          );
        }
      },
    );
  }
}
