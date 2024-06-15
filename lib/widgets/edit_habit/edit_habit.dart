import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class EditHabit extends StatefulWidget {
  const EditHabit(
      {super.key, required this.habit, required this.onUpdateHabit});

  final void Function(Habit habit) onUpdateHabit;
  final Habit habit;

  @override
  State<StatefulWidget> createState() {
    return _EditHabitState();
  }
}

class _EditHabitState extends State<EditHabit> {
  // ignore: prefer_typing_uninitialized_variables
  var _nameController;

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController(text: widget.habit.name);
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
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
              TextButton(
                child: const Text('Cancel', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "Edit Habit",
              ),
              TextButton(
                child: const Text('Save', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.pop(context);
                  widget.onUpdateHabit(Habit(
                    id: widget.habit.id,
                    name: _nameController.text,
                    isCompleted: widget.habit.isCompleted,
                    startDate: widget.habit.startDate,
                    endDate: widget.habit.endDate,
                  ));
                },
              ),
            ],
          ),
          Column(
            children: [
              const SizedBox(height: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  cursorColor: Colors.white,
                  maxLength: 50,
                  controller: _nameController,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 50.0),
            ],
          ),
        ],
      ),
    );
  }
}
