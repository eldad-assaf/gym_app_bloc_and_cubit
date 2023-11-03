import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp_flutter/blocs/workout_cubit.dart';
import 'package:gymapp_flutter/blocs/workouts_cubit.dart';
import 'package:gymapp_flutter/screens/edit_workout_screen.dart';
import 'package:gymapp_flutter/screens/home_page.dart';
import 'package:gymapp_flutter/screens/workout_in_progress.dart';
import 'package:gymapp_flutter/states/workout_states.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   HydratedBloc.storage = await HydratedStorage.build(storageDirectory: ...);
//   runApp(App());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const WorkoutTime());
}

class WorkoutTime extends StatelessWidget {
  const WorkoutTime({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Workouts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
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
            } else if (state is WorkoutInProgress || state is WorkoutPaused) {
              return const WorkoutProgress();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
