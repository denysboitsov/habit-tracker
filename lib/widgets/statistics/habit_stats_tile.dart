import 'package:auto_size_text/auto_size_text.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.width * 0.65,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: const Color.fromARGB(255, 43, 43, 43)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Column(
                  children: [
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.39,
                          child: AutoSizeText(
                            name,
                            style: Theme.of(context).textTheme.titleMedium,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 10.0,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: HeatMapCalendar(
                        fontSize: 9,
                        textColor: const Color.fromARGB(255, 0, 0, 0),
                        monthFontSize: 10,
                        weekFontSize: 10,
                        weekTextColor: Colors.white,
                        defaultColor: const Color.fromARGB(255, 55, 55, 55),
                        borderRadius: 5,
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
