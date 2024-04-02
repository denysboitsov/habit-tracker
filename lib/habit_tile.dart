import 'package:flutter/material.dart';
import 'package:habit_tracker/models/habit.dart';

class HabitTile extends StatefulWidget {
  const HabitTile({super.key, required this.habit, required this.notifyParent, required this.tileWidth});

  final Function() notifyParent;
  final Habit habit;
  final double tileWidth;

  @override
  State<HabitTile> createState() {
    return _HabitTileState();
  }
}

class _HabitTileState extends State<HabitTile> {
  var tileColor = Color.fromARGB(255, 0, 0, 0);

  Color getTileColor() {
    tileColor = widget.habit.isCompleted ? Color.fromARGB(255, 33, 33, 33) : Colors.black;
    return tileColor;
  }

  @override
  Widget build(context) {
    return Center(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return InkWell(
              onTap: () { 
                setState(() {
                  widget.habit.isCompleted = !widget.habit.isCompleted;
                });
                widget.notifyParent();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 33, 33, 33),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: getTileColor(),
                ),
                height: MediaQuery.of(context).size.width * widget.tileWidth/2,
                width: MediaQuery.of(context).size.width * widget.tileWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.habit.isCompleted) 
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          widget.habit.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    if (!widget.habit.isCompleted) 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.habit.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ]
                ),
              ),
            );
          },
        ),
    );
  }
}
