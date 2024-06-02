import 'package:habit_tracker/models/habit.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

final formatter = DateFormat.yMd();

class NewHabit extends StatefulWidget {
  const NewHabit({super.key, required this.onAddHabit});

  final void Function(Habit habit) onAddHabit;

  @override
  State<StatefulWidget> createState() {
    return _NewHabitState();
  }
}

class _NewHabitState extends State<NewHabit> {
  final _nameController = TextEditingController();

  void _submitNewHabit() {
    if (_nameController.text.trim().isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure a valid name was entered.'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDestructiveAction: false,
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddHabit(Habit(
      name: _nameController.text,
      isCompleted: false,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    _submitNewHabit();
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
