import 'package:habit_tracker/models/habit.dart';
import 'package:flutter/material.dart';

class LastWeekHeatmap extends StatelessWidget {
  const LastWeekHeatmap(
    this.habit, {
    super.key,
  });

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        SizedBox(width: 3,),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        SizedBox(width: 3,),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        SizedBox(width: 3,),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        SizedBox(width: 3,),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        SizedBox(width: 3,),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        SizedBox(width: 3,),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
      ],
    );
  }
}
