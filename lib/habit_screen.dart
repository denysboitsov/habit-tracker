import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tile.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  State<HabitScreen> createState() {
    return _HabitScreenState();
  }
}

class _HabitScreenState extends State<HabitScreen> {
  @override
  Widget build(context) {
    return const Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
          children: [
            SizedBox(width: 30,),
            HabitTile(),
          ],
        ),
        SizedBox(height: 30,),
      ]),
    );
  }
}
