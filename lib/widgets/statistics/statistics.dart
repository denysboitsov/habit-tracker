import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/helpers/db_helper.dart';
import 'package:habit_tracker/models/completion.dart';
import 'package:habit_tracker/models/habit.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  Future<Map<DateTime, int>> generateCompletionData() async {
    final Map<DateTime, int> data = {};

    var completions = await DatabaseHelper().getAllCompletions();

    // Define the date range
    DateTime startDate = DateTime.parse('2024-01-01');
    DateTime endDate = DateTime.parse('2024-12-31');

    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      currentDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
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
          completionsPercent.toInt();
    }
    return data;
  }

  Future<Map<String, List<Completion>>> getHabitCompletions() async {
    var completions = await DatabaseHelper().getAllCompletions();
    final Map<String, List<Completion>> allCompletions = {};
    // var habits = await DatabaseHelper().getHabits();
    

    for(var i = 0; i < completions.length; i++) {
      if (allCompletions[completions[i].name] != null) {
        allCompletions[completions[i].name]!.add(completions[i]);
      } else {
        allCompletions[completions[i].name] = [completions[i]]; 
      }
    }

    return allCompletions;


  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Year Overview",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          FutureBuilder<Map<DateTime, int>>(
            future: generateCompletionData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final completionData = snapshot.data;
                return HeatMap(
                  fontSize: 16,
                  defaultColor: Theme.of(context).primaryColor,
                  datasets: completionData,
                  colorMode: ColorMode.color,
                  showColorTip: false,
                  scrollable: true,
                  colorsets: {
                    0: Theme.of(context).primaryColor,
                    1: const Color.fromARGB(55, 62, 162, 255),
                    13: const Color.fromARGB(80, 62, 162, 255),
                    25: const Color.fromARGB(105, 62, 162, 255),
                    38: const Color.fromARGB(130, 62, 162, 255),
                    50: const Color.fromARGB(155, 62, 162, 255),
                    63: const Color.fromARGB(180, 62, 162, 255),
                    75: const Color.fromARGB(205, 62, 162, 255),
                    88: const Color.fromARGB(230, 62, 162, 255),
                    100: const Color.fromARGB(255, 62, 162, 255),
                  },
                  onClick: (value) {},
                );
              }
            },
          ),
          FutureBuilder<Map<String, List<Completion>>>(
            future: getHabitCompletions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final completions = snapshot.data;
                return HeatMapCalendar(
                  monthFontSize: 16,
                  weekFontSize: 12,
                  weekTextColor: Colors.white,
                  defaultColor: Theme.of(context).primaryColor,
                  borderRadius: 10,
                  showColorTip: false,
                  flexible: true,
                  colorMode: ColorMode.color,
                  datasets: {
                    DateTime(2021, 1, 6): 3,
                    DateTime(2021, 1, 7): 7,
                    DateTime(2021, 1, 8): 10,
                    DateTime(2021, 1, 9): 13,
                    DateTime(2021, 1, 13): 6,
                  },
                  colorsets: const {
                    1: Colors.red,
                    3: Colors.orange,
                    5: Colors.yellow,
                    7: Colors.green,
                    9: Colors.blue,
                    11: Colors.indigo,
                    13: Colors.purple,
                  },
                  onClick: (value) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(value.toString())));
                  },
                );
              }
            }
          ),
        ],
      ),
    );
  }
}
