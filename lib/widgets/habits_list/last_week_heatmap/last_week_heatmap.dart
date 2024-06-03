import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/models/completion.dart';
import 'package:habit_tracker/widgets/habits_list/last_week_heatmap/last_week_heatmap_item.dart';
import 'package:habit_tracker/helpers/db_helper.dart';
import 'package:intl/intl.dart';

class LastWeekHeatmap extends StatelessWidget {
  const LastWeekHeatmap(
    this.habit, {
    super.key,
  });

  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Completion>>(
      //future: fetchCompletions(),
      future: DatabaseHelper().getCompletions(
          habit,
          DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(Duration(days: 6))),
          DateFormat('yyyy-MM-dd').format(DateTime.now())),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3311).withOpacity(0),
                    border: Border.all(color: CupertinoTheme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3311).withOpacity(0),
                    border: Border.all(color:CupertinoTheme.of(context).primaryColor),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3311).withOpacity(0),
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3311).withOpacity(0),
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3311).withOpacity(0),
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3311).withOpacity(0),
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                width: 3,
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: Color(0xFF0E3311).withOpacity(0),
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                width: 3,
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final completions = snapshot.data!;
          return Row(
            children: completions.map((completion) {
              return Row(
                children: [
                  LastWeekHeatmapItem(completion),
                  SizedBox(
                    width: 3,
                  )
                ],
              );
            }).toList(),
          );
        }
      },
    );
  }
}
