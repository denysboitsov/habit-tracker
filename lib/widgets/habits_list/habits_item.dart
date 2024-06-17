import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/helpers/db_helper.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/widgets/edit_habit/edit_habit.dart';
import 'package:habit_tracker/widgets/habits_list/last_week_heatmap/last_week_heatmap.dart';
import 'package:intl/intl.dart';

class HabitsItem extends StatefulWidget {
  const HabitsItem(
    this.habit, {
    super.key,
    required this.onRemoveHabit,
  });

  final void Function(Habit habit) onRemoveHabit;
  final Habit habit;

  @override
  State<HabitsItem> createState() {
    return _HabitsItemState();
  }
}

class _HabitsItemState extends State<HabitsItem> {
  Future<void> _updateHabit(Habit habit) async {
    setState(() {
      DatabaseHelper().updateHabit(habit.id, habit.name);
    });
  }

  void _toggleHabit(Habit habit) {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    setState(() {
      habit.isCompleted = !habit.isCompleted;
    });
    DatabaseHelper().toggleCompletion(habit.id, date, habit.isCompleted);
  }

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
              widget.onRemoveHabit(widget.habit);
              Navigator.pop(context, 'Delete');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> _showActionSheet(BuildContext context, Habit habit) async {
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
          child: Text(
            'Edit',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: Text(
            'Delete',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
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
              return EditHabit(
                  habit: habit, onUpdateHabit: _updateHabit);
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Habit>(
      future: DatabaseHelper().getHabit(widget.habit),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final habit = snapshot.data;
          return GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              _toggleHabit(habit);
            },
            onLongPress: () {
              HapticFeedback.heavyImpact();
              _showActionSheet(context, habit);
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: habit!.isCompleted
                      ? const Color.fromARGB(255, 0, 39, 80)
                      : const Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(13.0),
                  border: Border.all(
                    color: habit.isCompleted
                        ? Colors.transparent
                        : const Color.fromARGB(255, 53, 53, 53),
                    width: 1.0,
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.48,
                height: MediaQuery.of(context).size.width * 0.24,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 13,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              habit.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 10.0,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
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
      },
    );
  }
}
