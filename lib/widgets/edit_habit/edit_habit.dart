import 'package:habit_tracker/models/habit.dart';
import 'package:flutter/material.dart';
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
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              //initialValue: widget.habit.name,
              maxLength: 50,
              //keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text("Name"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // removes the current overlay from the screen
                },
                child: Text('Cancel'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  widget.onUpdateHabit(Habit(id: widget.habit.id, name: _nameController.text, isCompleted: widget.habit.isCompleted));
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ]),
          ],
        ));
  }
}
