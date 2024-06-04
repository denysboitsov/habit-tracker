import 'dart:math';

import 'package:flutter/material.dart';
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
      child: HeatMap(
        datasets: completionData,
        colorMode: ColorMode.color,
        showColorTip: false,
        scrollable: true,
        colorsets: {
          1: Colors.red[100]!,
          2: Colors.red[200]!,
          3: Colors.red[300]!,
          4: Colors.red[400]!,
          5: Colors.red[500]!,
          6: Colors.red[600]!,
          7: Colors.red[700]!,
          8: Colors.red[800]!,
          9: Colors.red[900]!,
        },
        onClick: (value) {
          print("Clicked date: $value");
        },
      ),
    );
  }
}
