import 'package:flutter/material.dart';
import 'package:habit_tracker/helpers/db_helper.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/edit_habit/edit_habit.dart';
import 'package:habit_tracker/widgets/habits_list/last_week_heatmap/last_week_heatmap.dart';
import 'package:flutter/cupertino.dart';

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
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to dismiss dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                onRemoveHabit(habit);
                Navigator.of(context).pop();
                // Add code to delete item
              },
            ),
          ],
        );
      },
    );
  }

  void _onEditHabit(context, Habit habit) async {
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
    ).then((value) {
      if (value == 'delete') {
        _showDeleteConfirmationDialog(context);
      } else if (value == 'edit') {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (ctx) => EditHabit(
            habit: habit,
            onUpdateHabit: onUpdateHabit,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: CupertinoContextMenu.builder(
        enableHapticFeedback: true,
        actions: <Widget>[
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) => EditHabit(
                  habit: habit,
                  onUpdateHabit: onUpdateHabit,
                ),
              );
            },
            isDefaultAction: true,
            trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
            child: const Text('Edit'),
          ),
          CupertinoContextMenuAction(
            onPressed: () {
              Navigator.pop(context);
              _showDeleteConfirmationDialog(context);
            },
            isDestructiveAction: true,
            trailingIcon: CupertinoIcons.delete,
            child: const Text('Delete'),
          ),
        ],
        builder: (BuildContext context, Animation<double> animation) {
          return GestureDetector(
            onTap: () {
              onToggleHabit(habit);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.48,
              height: MediaQuery.of(context).size.width * 0.24,
              child: Card.outlined(
                color:
                    habit.isCompleted ? Color.fromARGB(255, 204, 204, 204) : null,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(habit.name),
                        ],
                      ),
                      SizedBox(
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
      ),
    );
  }
}
