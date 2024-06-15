import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:intl/intl.dart';

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
  DateTime startDate = DateTime.now();
  DateTime? endDate;
  String startDateButtonText = "Today";
  String endDateButtonText = "No End Date";

  void _submitNewHabit() {
    if (_nameController.text.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure a valid name was entered.'),
          actions: <Widget>[
            TextButton(
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
    if (endDate != null && !endDate!.isAfter(startDate)) {
      showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content:
              const Text('Please make sure start date is before end date.'),
          actions: <Widget>[
            TextButton(
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
      startDate: startDate,
      endDate: endDate,
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
        color: Color.fromARGB(255, 31, 31, 31),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Text(
                "Add Habit",
              ),
              MaterialButton(
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _submitNewHabit();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Name",
                    ),
                  ),
                ),
                TextField(
                  maxLength: 50,
                  controller: _nameController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "Start Date",
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: MaterialButton(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(0),
                              child: Text(startDateButtonText),
                              onPressed: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null &&
                                    picked != DateTime.now()) {
                                  setState(() {
                                    startDate = picked;
                                    startDateButtonText =
                                        DateFormat('yyyy-MM-dd')
                                            .format(startDate)
                                            .toString();
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "End Date",
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.1,
                          child: MaterialButton(
                              color: Colors.blue,
                              padding: const EdgeInsets.all(0),
                              child: Text(endDateButtonText),
                              onPressed: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                );
                                if (picked != null &&
                                    picked != DateTime.now()) {
                                  setState(() {
                                    endDate = picked;
                                    endDateButtonText = DateFormat('yyyy-MM-dd')
                                        .format(startDate)
                                        .toString();
                                  });
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
