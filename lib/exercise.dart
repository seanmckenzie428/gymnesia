import 'package:flutter/material.dart';

class Exercise {
  String name;
  Icon icon;

  Exercise({required this.name, this.icon = const Icon(Icons.fitness_center)});

  ListTile listTile() {
    return ListTile(
      title: Text(name),
    );
  }
}
