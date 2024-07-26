import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/models/completion.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:habit_tracker/helpers/db_helper.dart';

class HabitStatisticTile extends StatelessWidget {
  const HabitStatisticTile({
    super.key,
    required this.completions,
    required this.name,
  });

  final Map<DateTime, int> completions;
  final String name;

  Future<int> CalculateAllTimeCompletion(Habit habit) async {
    DateTime date1 = habit.startDate; // Date format: YYYY-MM-DD
    DateTime date2 = DateTime.now();
    int differenceInDays = date2.difference(date1).inDays;
    return differenceInDays;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: const Color.fromARGB(255, 43, 43, 43)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: MediaQuery.of(context).size.width * 0.55,
                    child: HeatMapCalendar(
                      textColor: const Color.fromARGB(255, 0, 0, 0),
                      monthFontSize: 16,
                      weekFontSize: 12,
                      weekTextColor: Colors.white,
                      defaultColor: const Color.fromARGB(255, 55, 55, 55),
                      borderRadius: 7,
                      showColorTip: false,
                      flexible: true,
                      colorMode: ColorMode.color,
                      datasets: completions,
                      colorsets: const {
                        1: Colors.blue,
                      },
                      onClick: (value) {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 65, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("All-time: 50%"),
                        Text("Streak: 22w",
                            maxLines: 2, overflow: TextOverflow.visible),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
