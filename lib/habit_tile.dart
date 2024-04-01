import 'package:flutter/material.dart';

class HabitTile extends StatefulWidget {
  const HabitTile({super.key, required this.name, required this.isCompleted});

  final String name;
  final bool isCompleted;

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
            return InkWell(
              onTap: () { 
                  print("Tapped on container"); 
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(15))
                ),
                height: MediaQuery.of(context).size.width/2*0.5,
                width: MediaQuery.of(context).size.width/2*0.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.isCompleted) 
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.white,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    if (!widget.isCompleted) 
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ]
                ),
              ),
            );
          },
        ),
    );
  }
}
