import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/edit_habit/edit_habit.dart';
import 'package:habit_tracker/widgets/habits_list/last_week_heatmap/last_week_heatmap.dart';

class HabitsItem extends StatelessWidget {
  const HabitsItem(
    this.habit, {
    super.key,
    required this.onToggleHabit,
    required this.onRemoveHabit,
    required this.onUpdateHabit,
  });

  final void Function(Habit habit) onUpdateHabit;
  final void Function(Habit habit) onToggleHabit;
  final void Function(Habit habit) onRemoveHabit;
  final Habit habit;

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete habit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onRemoveHabit(habit);
              Navigator.pop(context, 'Delete');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _showActionSheet(BuildContext context) async {
    final RenderBox cardRenderBox = context.findRenderObject() as RenderBox;
    final RenderBox overlayRenderBox =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset cardPosition =
        cardRenderBox.localToGlobal(Offset.zero, ancestor: overlayRenderBox);

    final RelativeRect position = RelativeRect.fromLTRB(
      cardPosition.dx,
      cardPosition.dy + cardRenderBox.size.height,
      overlayRenderBox.size.width - cardPosition.dx - cardRenderBox.size.width,
      overlayRenderBox.size.height -
          cardPosition.dy -
          cardRenderBox.size.height,
    );

    await showMenu<String>(
      context: context,
      position: position,
      items: <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: Text('Edit'),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    ).then((String? value) {
      if (value == "delete") {
        //Navigator.pop(context);
        _showDeleteConfirmationDialog(context);
      }
      if (value == "edit") {
        //Navigator.pop(context);
        showModalBottomSheet(
            barrierColor: Colors.transparent,
            context: context,
            builder: (context) {
              return EditHabit(habit: habit, onUpdateHabit: onUpdateHabit);
            });
      }
    });
    // showCupertinoModalPopup<void>(
    //   context: context,
    //   builder: (BuildContext context) => CupertinoActionSheet(
    //     title: const Text('Options'),
    //     // message: const Text('Message'),
    //     actions: <CupertinoActionSheetAction>[
    //       CupertinoActionSheetAction(
    //         onPressed: () {
    //           Navigator.pop(context);
    //           showCupertinoModalPopup(
    //               barrierColor: Colors.transparent,
    //               context: context,
    //               builder: (context) {
    //                 return EditHabit(
    //                     habit: habit, onUpdateHabit: onUpdateHabit);
    //               });
    //         },
    //         child: const Text('Edit'),
    //       ),
    //       CupertinoActionSheetAction(
    //         isDestructiveAction: true,
    //         onPressed: () {
    //           Navigator.pop(context);
    //           _showDeleteConfirmationDialog(context);
    //         },
    //         child: const Text('Delete'),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onToggleHabit(habit);
      },
      onLongPress: () {
        HapticFeedback.heavyImpact();
        _showActionSheet(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
            color: habit.isCompleted
                ? const Color.fromARGB(255, 0, 39, 80)
                : Colors.blue,
            borderRadius:
                BorderRadius.circular(15.0), // Customize the radius here
            border: Border.all(
              color:
                  habit.isCompleted ? Colors.blue.withOpacity(0) : Colors.blue,
              // Customize the color here
              width: 1.0, // Customize the border width if needed
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.48,
          height: MediaQuery.of(context).size.width * 0.24,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      habit.name,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    LastWeekHeatmap(
                      habit,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
