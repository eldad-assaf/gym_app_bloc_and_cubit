import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';
import 'package:wakelock/wakelock.dart';
import '../states/workout_states.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit() : super(const WorkoutInitial());

  Timer? _timer;

  editWorkout(Workout workout, int index) =>
      emit(WorkoutEditing(workout, index, null));

  editExercise(int? exIndex) => emit(
      WorkoutEditing(state.workout, (state as WorkoutEditing).index, exIndex));

  // onTick(Timer timer) {
  //   if (state is WorkoutInProgress) {
  //     WorkoutInProgress wip = state as WorkoutInProgress;
  //     if (wip.elapsed! < wip.workout!.getTotal()) {
  //       emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
  //       print('elapsed time is ${wip.elapsed}...');
  //     } else {
  //       timer.cancel();
  //       Wakelock.disable();
  //       emit(const WorkoutInitial());
  //     }
  //   }
  // }
  onTick(Timer timer) {
    if (state is! WorkoutInProgress) return;

    WorkoutInProgress wip = state as WorkoutInProgress;
    if (wip.elapsed! >= wip.workout!.getTotal()) {
      timer.cancel();
      Wakelock.disable();
      emit(const WorkoutInitial());
      return;
    }

    emit(WorkoutInProgress(wip.workout, wip.elapsed! + 1));
  }

//the index is for starting a workout in a specific exercide (not the first excersice in the list)
  startWorkout(Workout workout, [int? index]) async {
    Wakelock.enable();

    if (index != null) {
    } else {
      emit(WorkoutInProgress(workout, 0));
      _timer = Timer.periodic(const Duration(seconds: 1), onTick);
    }
  }

  goHome() {
    if (_timer != null) {
      _timer!.cancel();
    }
    emit(const WorkoutInitial());
  }
}
