import 'package:flutter_bloc_app_complete/models/exercise.dart';

class Workout {
  final String? title;
  final List<Exercise> exercises;

  const Workout({
    required this.title,
    required this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    int startTime = 0;

    for (var ex in (json['exercises'] as Iterable)) {
      exercises.add(Exercise.fromJson(ex, index, startTime));
      index++;
      //+=(Add and Assignment)
      //It adds the right operand to the left operand and assigns the result to the left operand.
      //Ex: C += A is equivalent to C = C + A
      startTime += exercises.last.prelude! + exercises.last.startTime!;
    }

    return Workout(title: json['title'] as String?, exercises: exercises);
  }
}
