import 'dart:math';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers.dart';
import 'package:flutter_bloc_app_complete/models/exercise.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

import '../models/workout.dart';

class WorkoutProgress extends StatelessWidget {
  const WorkoutProgress({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _getStats(Workout workout, int workoutElapsed) {
      int workoutTotal = workout.getTotal();
      Exercise exercise = workout.getCurrentExercise(workoutElapsed);
      int exerciseElapsed = workoutElapsed - exercise.startTime!;
      int exerciseRemaining =
          exercise.prelude! - exerciseElapsed; //check 4:52:00 4:55:55
      bool isPrelude = exerciseElapsed < exercise.prelude!;
      int exerciseTotal = isPrelude ? exercise.prelude! : exercise.duration!;
      if (!isPrelude) {
        exerciseElapsed -= exercise.prelude!;
        exerciseRemaining += exercise.duration!;
      }

      return {
        'workoutTitle': workout.title,
        'workoutTotal': workoutTotal,
        'workoutProgress': workoutElapsed / workoutTotal,
        'workoutElapsed': workoutElapsed,
        'totalExercise': workout.exercises.length,
        'currentExerciseIndex': exercise.index!.toDouble(),
        'workoutRemaining': workoutTotal - workoutElapsed,
        'exerciseRemaining': exerciseRemaining,
        'isPrelude': isPrelude,
        'exerciseProgress': exerciseElapsed / exerciseTotal
      };
    }

    return BlocConsumer<WorkoutCubit, WorkoutState>(
      builder: (context, state) {
        final stats = _getStats(state.workout!, state.elapsed!);

        return Scaffold(
          body: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                LinearProgressIndicator(
                  backgroundColor: Colors.blue[100],
                  minHeight: 10,
                  value: stats['workoutProgress'],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Text(
                        formatTime(stats['workoutElapsed'], true),
                      ),
                      DotsIndicator(
                        dotsCount: stats['totalExercise'],
                        position: stats['currentExerciseIndex'],
                      ),
                      Text(
                        formatTime(stats['workoutRemaining'], true),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      if (state is WorkoutInProgress) {
                        BlocProvider.of<WorkoutCubit>(context).pauseWorkout();
                      } else if (state is WorkoutPaused) {
                        BlocProvider.of<WorkoutCubit>(context).resumeWorkout();
                      }
                    },
                    child: Stack(
                      alignment: const Alignment(0, 0),
                      children: [
                        Center(
                          child: SizedBox(
                            height: 220,
                            width: 220,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  stats['isPrelude']
                                      ? Colors.red
                                      : Colors.blue),
                              strokeWidth: 25,
                              value: stats['exerciseProgress'],
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Image.asset('stopwatch.png'),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('${state.workout!.title}'),
            leading: BackButton(
              onPressed: () => BlocProvider.of<WorkoutCubit>(context).goHome(),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
