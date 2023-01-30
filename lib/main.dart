//https://www.youtube.com/watch?v=1ENQHfNB9gM&t=34s
//https://www.dbestech.com/tutorials/flutter-bloc-app-complete-tutorial-advanced
//https://app.quicktype.io

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/screens/edit_workout_screen.dart';
import 'package:flutter_bloc_app_complete/screens/home_page.dart';
import 'package:flutter_bloc_app_complete/states/workout_states.dart';

void main() => runApp(const WorkoutTime());

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            color: Color.fromARGB(155, 66, 74, 96),
          ),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<WorkoutsCubit>(
            create: ((context) {
              WorkoutsCubit workoutsCubit = WorkoutsCubit();
              if (workoutsCubit.state.isEmpty) {
                workoutsCubit.getWorkouts();
              }

              return workoutsCubit;
            }),
          ),
          BlocProvider<WorkoutCubit>(
            create: (context) => WorkoutCubit(),
          )
        ],
        child: BlocBuilder<WorkoutCubit, WorkoutState>(
          builder: (context, state) {
            if (state is WorkoutInitial) {
              return const HomePage();
            } else if (state is WorkoutEditing) {
              return const EditWorkoutScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
