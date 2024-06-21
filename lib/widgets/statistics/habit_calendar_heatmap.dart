import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/models/completion.dart';

class HabitCalendarItem extends StatelessWidget {
  const HabitCalendarItem({
    super.key, required this.completions,
  });

  final Map<DateTime, int> completions;
  
  @override
  Widget build(BuildContext context) {
    //print(completions);
    return HeatMapCalendar(
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
    );
  }
}
