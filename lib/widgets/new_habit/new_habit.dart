import 'package:habit_tracker/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewHabit extends StatefulWidget {
  const NewHabit({super.key,required this.onAddHabit});

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
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
            title: Text('Invalid input'),
            content: const Text(
                'Please make sure a valid name was entered.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text("Okay"),
              )
            ]),
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
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              //keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text("Name"),
              ),
            ),
            SizedBox(height: 20,),
            Row(children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                      context); // removes the current overlay from the screen
                },
                child: Text('Cancel'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitNewHabit,
                child: Text('Save'),
              ),
            ]),
          ],
        ));
  }
}
