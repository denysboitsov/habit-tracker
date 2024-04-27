// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:habit_tracker/habits_screen/habit_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:habit_tracker/db_interface.dart';
import 'package:habit_tracker/models/habit.dart';

class HabitScreen extends StatefulWidget {
  HabitScreen({super.key});

  @override
  State<HabitScreen> createState() {
    return _HabitScreenState();
  }
}

class _HabitScreenState extends State<HabitScreen> {

  final DB db = DB();
  final PanelController _pc = new PanelController();
  final TextEditingController habitNameController = TextEditingController();


  @override
  Widget build(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
        onTap: () {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        onPanUpdate: (details) {
          // Swiping in right direction.
          currentFocus.unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text("Today"),
            titleTextStyle: TextStyle(
              color: Color.fromARGB(255, 222, 222, 222),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            actions: [
              IconButton(
                iconSize: MediaQuery.of(context).size.width * 0.1,
                onPressed: () => _pc.open(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Color.fromARGB(255, 222, 222, 222),
                ),
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          body: Stack(
            children: [
              HabitList(),
              SlidingUpPanel(
                //backdropEnabled: true,
                // backdropColor: Color.fromARGB(255, 53, 53, 53),
                // backdropOpacity: 0.5,
                controller: _pc,
                minHeight: 0,
                maxHeight: 790,
                color: Colors.black,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 30.0,
                    color: Color.fromARGB(255, 60, 60, 60),
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                panel: Container(
                  //color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Text(
                          "Habit name",
                          style: TextStyle(
                            color: Color.fromARGB(255, 222, 222, 222),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25.0, right: 25),
                        child: TextField(
                          controller: habitNameController,
                          cursorColor: Color.fromARGB(255, 222, 222, 222),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 222, 222, 222),
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Habit name',
                          ),
                          style: TextStyle(
                            color: Color.fromARGB(255, 222, 222, 222),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: OutlinedButton(
                          onPressed: () {
                            db.insertHabit(Habit(habitNameController.text));
                            db.getAllHabits();
                              // Clean up the controller when the widget is disposed.
                          },
                          child: const Text('Create'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
