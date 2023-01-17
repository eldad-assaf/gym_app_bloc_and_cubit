//https://www.youtube.com/watch?v=1ENQHfNB9gM&t=34s
//https://www.dbestech.com/tutorials/flutter-bloc-app-complete-tutorial-advanced
//https://app.quicktype.io

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/screens/home_page.dart';
import 'models/workout.dart';

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
      home: BlocProvider<WorkoutsCubit>(
        create: ((context) {
          WorkoutsCubit workoutsCubit = WorkoutsCubit();
          if (workoutsCubit.state.isEmpty) {
            workoutsCubit.getWorkouts();
          }

          return workoutsCubit;
        }),
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
          builder: ((context, state) {
            return const HomePage();
          }),
        ),
      ),
    );
  }
}
