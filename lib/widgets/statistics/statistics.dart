import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/helpers/db_helper.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Future<Map<DateTime, int>> generateCompletionData() async {
    final Map<DateTime, int> data = {};

    var completions = await DatabaseHelper().getAllCompletions();

    // Define the date range
    DateTime startDate = DateTime.parse('2024-01-01');
    DateTime endDate = DateTime.parse('2024-12-31');

    // Generate random completion counts for each day in the range
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      currentDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      //data[currentDate] = 0;
      var completedHabits = completions
          .where((completion) =>
              completion.isCompleted &&
              completion.completionDate == currentDate)
          .toList();
      var allHabits = completions
          .where((completion) => completion.completionDate == currentDate)
          .toList();
      var completionsPercent = allHabits.isEmpty
          ? 0
          : completedHabits.length / allHabits.length * 100;
      data[DateTime(currentDate.year, currentDate.month, currentDate.day)] =
          completionsPercent.toInt(); // Random completions between 0 and 9
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<DateTime, int>>(
      future: generateCompletionData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Row();
          //return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Row();
          //return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final completionData = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Year Overview",
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                HeatMap(
                  defaultColor: Color.fromARGB(255, 20, 35, 79),
                  datasets: completionData,
                  colorMode: ColorMode.color,
                  showColorTip: false,
                  scrollable: true,
                  colorsets: {
                    0: Color.fromARGB(255, 20, 35, 79),
                    50: Color.fromARGB(255, 35, 60, 135),
                    100: Color.fromARGB(255, 65, 109, 242),
                  },
                  onClick: (value) {
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
