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
        color: Theme.of(context).primaryColor,
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
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const Text(
                "Edit Habit",
              ),
              TextButton(
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
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
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color.fromARGB(255, 120, 120, 120), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    //suffixIcon: Icon(Icons.clear),
                    //labelText: 'Habit name',
                    //hintText: 'Habit name',
                    //helperText: 'supporting text',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  cursorColor: Colors.white,
                  maxLength: 50,
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
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
