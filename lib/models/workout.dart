import 'package:flutter_bloc_app_complete/models/exercise.dart';

class Workout {
  final String? title;
  final List<Exercise> exercises;

  const Workout({
    required this.title,
    required this.exercises,
  });
//min 25:00 , 26:50 

  factory Workout.fromJson(Map<String, dynamic> json) {
    List<Exercise> exercises = [];
    int index = 0;
    int startTime = 0;

    //////min 25:00 in the video
    for (var ex in (json['exercises'] as Iterable)) {
    //min 26:50 
      exercises.add(Exercise.fromJson(ex, index, startTime));
    }
  }
}
