import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class StatsPage extends StatelessWidget {
  StatsPage({super.key});

  Map<DateTime, int> generateDummyCompletionData() {
    final Map<DateTime, int> data = {};
    final random = Random();

    // Define the date range
    DateTime startDate = DateTime(2023, 1, 1);
    DateTime endDate = DateTime(2023, 12, 31);

    // Generate random completion counts for each day in the range
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      data[currentDate] =
          random.nextInt(10); // Random completions between 0 and 9
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    var completionData = generateDummyCompletionData();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Year Overview",
              style: CupertinoTheme.of(context)
                  .textTheme
                  .navLargeTitleTextStyle
                  .copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(height: 14,),
          HeatMap(
            defaultColor: Color.fromARGB(255, 0, 39, 80),
            datasets: completionData,
            colorMode: ColorMode.opacity,
            showColorTip: false,
            scrollable: true,
            colorsets: {
              1: CupertinoTheme.of(context).primaryColor,
            },
            onClick: (value) {
              print("Clicked date: $value");
            },
          ),
        ],
      ),
    );
  }
}
