// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tile.dart';
import 'package:habit_tracker/data/habits.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() {
    return _HabitScreenState();
  }
}

class _HabitScreenState extends State<HabitScreen> {
  final double tileWidth = 0.47;

  refresh() {
    setState(() {
      habits.sort((a, b) =>
          a.isCompleted.toString().compareTo(b.isCompleted.toString()));
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
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
            onPressed: () {
              
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 222, 222, 222),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            //color: Colors.red,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < habits.length / 2; i++)
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width *
                                ((0.5 - tileWidth) / 2)),
                        child: HabitTile(
                          habit: habits[i * 2],
                          notifyParent: refresh,
                          tileWidth: tileWidth,
                        ),
                      ),
                      if (i * 2 + 1 < habits.length)
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width *
                                  ((0.5 - tileWidth) / 2)),
                          child: HabitTile(
                            habit: habits[i * 2 + 1],
                            notifyParent: refresh,
                            tileWidth: tileWidth,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
          SlidingUpPanel(
            minHeight: 50,
            maxHeight: 750,
            color: Colors.black,
            border: Border.all(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            panel: Center(
              child: Text("This is the sliding Widget"),
            ),
          ),
        ],
      ),
    );
  }
}
