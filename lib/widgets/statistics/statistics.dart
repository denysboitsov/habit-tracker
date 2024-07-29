import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/helpers/db_helper.dart';
import 'package:habit_tracker/widgets/statistics/habit_stats_tile.dart';

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

  List<Map<String, Map>> splitMap(Map<String, Map> map) {
    int length = map.length;
    int midpoint = (length + 1) ~/ 2; // Divide and round up

    Map<String, Map> firstMap = {};
    Map<String, Map> secondMap = {};

    int index = 0;
    map.forEach((key, value) {
      if (index < midpoint) {
        firstMap[key] = value;
      } else {
        secondMap[key] = value;
      }
      index++;
    });

    return [firstMap, secondMap];
  }

  Future<Map<String, Map<DateTime, int>>> getHabitCompletions() async {
    var completions = await DatabaseHelper().getAllCompletions();
    final Map<String, Map<DateTime, int>> allCompletions = {};

    for (var i = 0; i < completions.length; i++) {
      if (allCompletions[completions[i].name] == null) {
        allCompletions[completions[i].name] = {};
      }
      allCompletions[completions[i].name]![completions[i].completionDate] =
          (completions[i].isCompleted ? 1 : 0);
    }
    return allCompletions;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Year Overview",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          FutureBuilder<Map<DateTime, int>>(
            future: generateCompletionData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Row();
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
                    0: const Color.fromARGB(255, 55, 55, 55),
                    1: const Color.fromARGB(55, 62, 162, 255),
                    13: const Color.fromARGB(80, 62, 162, 255),
                    25: const Color.fromARGB(105, 62, 162, 255),
                    38: const Color.fromARGB(130, 62, 162, 255),
                    50: const Color.fromARGB(155, 62, 162, 255),
                    63: const Color.fromARGB(180, 62, 162, 255),
                    75: const Color.fromARGB(205, 62, 162, 255),
                    88: const Color.fromARGB(230, 62, 162, 255),
                    100: Colors.blue,
                  },
                  onClick: (value) {},
                );
              }
            },
          ),
          const SizedBox(
            height: 14,
          ),
          FutureBuilder<Map<String, Map<DateTime, int>>>(
              future: getHabitCompletions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Row();
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  Map<String, Map<DateTime, int>> completions = snapshot.data!;
                  List<Map<String, Map>> splitMaps = splitMap(completions);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ...splitMaps[0].keys.map(
                            (completion) => HabitStatisticTile(
                                completions: snapshot.data![completion]!,
                                name: completion),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          ...splitMaps[1].keys.map(
                            (completion) => HabitStatisticTile(
                                completions: snapshot.data![completion]!,
                                name: completion),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }),
        ],
      ),
    );
  }
}
