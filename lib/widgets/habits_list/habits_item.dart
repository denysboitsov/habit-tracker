import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete habit?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              onRemoveHabit(habit);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
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
    late int pressTime = 0;
    final Stopwatch stopwatch = Stopwatch();
    return SizedBox(
      child: CupertinoContextMenu.builder(
          enableHapticFeedback: true,
          actions: <Widget>[
            CupertinoContextMenuAction(
              onPressed: () {
                HapticFeedback.lightImpact();
                onToggleHabit(habit);
                Navigator.pop(context);
              },
              isDefaultAction: false,
              isDestructiveAction: false,
              trailingIcon: CupertinoIcons.check_mark_circled,
              child: const Text('Toggle completion'),
            ),
            CupertinoContextMenuAction(
              onPressed: () {
                Navigator.pop(context);
                showCupertinoModalPopup(
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return EditHabit(
                          habit: habit, onUpdateHabit: onUpdateHabit);
                    });
              },
              isDefaultAction: false,
              trailingIcon: CupertinoIcons.pencil_circle,
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
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: habit.isCompleted
                      ? Color.fromARGB(255, 0, 39, 80)
                      : CupertinoTheme.of(context).scaffoldBackgroundColor,
                  borderRadius:
                      BorderRadius.circular(15.0), // Customize the radius here
                  border: Border.all(
                    color: habit.isCompleted
                        ? CupertinoTheme.of(context)
                            .primaryContrastingColor
                            .withOpacity(0)
                        : CupertinoTheme.of(context)
                            .primaryContrastingColor, // Customize the color here
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
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navLargeTitleTextStyle
                                .copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
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
            );
          }),
    );
  }
}
