import 'package:habit_tracker/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewHabit extends StatefulWidget {
  const NewHabit({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewHabitState();
  }
}

class _NewHabitState extends State<NewHabit> {
  final _nameController = TextEditingController();
  DateTime? _selectedStartDate; 
  DateTime? _selectedEndDate; 

  void _startDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedStartDate = pickedDate;
    });
  }

  void _endDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedEndDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedStartDate == null ? "Start date" : "Start date: " + formatter.format(_selectedStartDate!)), // ! forces dart to assume that this cannot be null
                      IconButton(
                        onPressed: _startDatePicker,
                        icon: Icon(Icons.calendar_month),
                      ),
                      Spacer(),
                      Text(_selectedEndDate == null ? "End date" : "End date: " + formatter.format(_selectedEndDate!)), // ! forces dart to assume that this cannot be null
                      IconButton(
                        onPressed: _endDatePicker,
                        icon: Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(children: [
              ElevatedButton(
                onPressed: () {
                  print(_nameController.text);
                },
                child: Text('Save'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context); // removes the current overlay from the screen
                },
                child: Text('Cancel'),
              )
            ]),
          ],
        ));
  }
}
