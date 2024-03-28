import 'package:flutter/material.dart';

class HabitTile extends StatefulWidget {
  const HabitTile({super.key});

  @override
  State<HabitTile> createState() {
    return _HabitTileState();
  }
}

class _HabitTileState extends State<HabitTile> {
  @override
  Widget build(context) {
    return Center(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              height: MediaQuery.of(context).size.width/2-40,
              width: MediaQuery.of(context).size.width/2-40,
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Drink some fucking water or something.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ]
              ),
            );
          },
        ),
    );
  }
}
