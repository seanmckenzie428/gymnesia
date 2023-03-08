import 'package:gymnesia/exercise.dart';

class Workout {
  List<Exercise> exercises = <Exercise>[];
  DateTime date = DateTime.now();

  Workout();

  void addExercise(Exercise exercise) {
    exercises.insert(0, exercise);
  }

  void removeExercise(Exercise exercise) {
    exercises.remove(exercise);
  }
}
