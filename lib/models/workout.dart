import 'package:equatable/equatable.dart';
import 'package:gymapp_flutter/models/exercise.dart';

class Workout extends Equatable {
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
      startTime += exercises.last.prelude! + exercises.last.duration!;
    }

    return Workout(title: json['title'] as String?, exercises: exercises);
  }
  Map<String, dynamic> toJson() => {'title': title, 'exercises': exercises};

  copyWith({String? title}) =>
      Workout(title: title ?? this.title, exercises: exercises);

  int getTotal() =>
      exercises.fold(0, (prev, ex) => prev + ex.duration! + ex.prelude!);

  Exercise getCurrentExercise(int? elapsed) =>
      exercises.lastWhere((element) => element.startTime! <= elapsed!);

  Exercise? getNextExercise(Workout workout, int? elapsed) {
    final currentExercise = workout.getCurrentExercise(elapsed);
    final currentExerciseIndex = workout.exercises.indexOf(currentExercise);
    final nextExerciseIndex = currentExerciseIndex + 1;

    if (nextExerciseIndex >= workout.exercises.length) {
      return null; // No more exercises in the workout
    }

    return workout.exercises[nextExerciseIndex];
  }

  @override
  List<Object?> get props => [title, exercises];

  @override
  bool get stringify => true;
}
