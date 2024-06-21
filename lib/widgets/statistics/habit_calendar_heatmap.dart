import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/models/completion.dart';

class HabitCalendarItem extends StatelessWidget {
  const HabitCalendarItem({
    super.key,
    required this.completions,
    required this.name,
  });

  final Map<DateTime, int> completions;
  final String name;

  @override
  Widget build(BuildContext context) {
    //print(completions);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          HeatMapCalendar(
            textColor: Colors.white,
            monthFontSize: 16,
            weekFontSize: 12,
            weekTextColor: Colors.white,
            defaultColor: Theme.of(context).primaryColor,
            borderRadius: 10,
            showColorTip: false,
            flexible: true,
            colorMode: ColorMode.color,
            datasets: completions,
            colorsets: const {
              1: Colors.blue,
            },
            onClick: (value) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.toString())));
            },
          ),
        ],
      ),
    );
  }
}
