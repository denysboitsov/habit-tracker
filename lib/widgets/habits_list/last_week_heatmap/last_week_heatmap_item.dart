import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/models/completion.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/helpers/db_helper.dart';


class LastWeekHeatmapItem extends StatelessWidget {
  const LastWeekHeatmapItem(
    this.completion, {
    super.key,
  });

  final Completion completion;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              color: completion.isCompleted? Colors.blue : Colors.white,
              border: Border.all(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(4))),
        );
  }
}
