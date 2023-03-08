import 'package:flutter/material.dart';
import 'package:gymnesia/exercise.dart';

class StrengthExercise extends Exercise {
  int reps;
  int sets;
  double weight;

  StrengthExercise(
      {required super.name,
      super.icon,
      required this.reps,
      required this.sets,
      required this.weight});

  @override
  ListTile listTile() {
    // TODO: implement listTile
    return super.listTile();
  }
}
