import 'package:habit_tracker/models/completion.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastWeekHeatmapItem extends StatelessWidget {
  const LastWeekHeatmapItem(
    this.completion,
    this.isParentCompleted, {
    super.key,
  });

  final Completion completion;
  final bool isParentCompleted;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //       child: Center(child: Text(DateFormat("ccccc").format(completion.completionDate), style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 9, fontWeight: FontWeight.bold),)),
    //       width: 15,
    //       height: 15,
    //       decoration: BoxDecoration(
    //           color: completion.isCompleted? Colors.blue : const Color(0xFF0E3311).withOpacity(0),
    //           border: Border.all(color: Colors.blueAccent),
    //           borderRadius: const BorderRadius.all(Radius.circular(4))),
    //     );
    return completion.isCompleted
        ? Icon(
            Icons.check_circle_rounded,
            size: 20,
            color: isParentCompleted? Color.fromARGB(255, 177, 0, 1) : Colors.black,
          )
        : Icon(Icons.circle, size: 20, color: isParentCompleted? Color.fromARGB(255, 177, 0, 1) : Colors.black);
  }
}
