import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp_flutter/models/workout.dart';
import 'package:wakelock/wakelock.dart';
import '../states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  Timer? _timer;

  editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  editExercise(int? exIndex) => emit(
      WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));

  pauseWorkout() => emit(WorkoutPaused(state.workout, state.elapsed));
  resumeWorkout() => emit(WorkoutInProgress(state.workout, state.elapsed));

  onTick(Timer timer) {
    if (state is WorkoutInProgress) {
      WorkoutInProgress wip = state as WorkoutInProgress;
      if (wip.elapsed! < wip.workout!.getTotal()) {
        emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
      } else {
        timer.cancel();
        Wakelock.disable();
        emit(const WorkoutInitial());
      }
    }
  }

//the index is for starting a workout in a specific exercide (not the first excersice in the list)
  startWorkout(Workout workout, [int? index]) async {
    Wakelock.enable();
    if (_timer != null) {
      _timer!.cancel();
    }
    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
      _timer = Timer.periodic(const Duration(seconds: 1), onTick);
    }
  }

  goHome() {
    if (_timer != null) {
      print('timer stopped');
      _timer!.cancel();
      _timer = null;
    }
    emit(const WorkoutInitial());
  }
}
