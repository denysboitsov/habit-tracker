import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';


const uuid = Uuid();


class Habit {
  Habit({
    required this.name,
  }) : id = uuid.v4();

  final String id;
  final String name;
}
