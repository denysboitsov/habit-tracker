import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class EditHabit extends StatefulWidget {
  const EditHabit({super.key, required this.habit, required this.onUpdateHabit});

  final void Function(Habit habit) onUpdateHabit;
  final Habit habit;

  @override
  State<StatefulWidget> createState() {
    return _EditHabitState();
  }
}

class _EditHabitState extends State<EditHabit> {
  var _nameController;

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: widget.habit.name);
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground.resolveFrom(context),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: CupertinoButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                child: Text(
                  "Add Habit",
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                ),
              ),
              Container(
                child: CupertinoButton(
                  child: Text('Save'),
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onUpdateHabit(Habit(id: widget.habit.id, name: _nameController.text, isCompleted: widget.habit.isCompleted));
                  },
                ),
              ),
            ],
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CupertinoTextField(
                    maxLength: 50,
                    controller: _nameController,
                    placeholder: 'Name',
                    padding: EdgeInsets.all(16.0),
                  ),
                ),
                SizedBox(height: 100.0),
              ],
            ),
          ),
        ],
      ),
    );
    
  }
}
