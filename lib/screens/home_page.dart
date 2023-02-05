import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app_complete/blocs/workout_cubit.dart';
import 'package:flutter_bloc_app_complete/blocs/workouts_cubit.dart';
import 'package:flutter_bloc_app_complete/helpers.dart';
import 'package:flutter_bloc_app_complete/models/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout time!'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.event_available)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<WorkoutsCubit, List<Workout>>(
            builder: ((context, workouts) => ExpansionPanelList.radio(
                  children: workouts.map((workout) {
                    return ExpansionPanelRadio(
                        value: workout,
                        headerBuilder: ((context, isExpanded) => ListTile(
                              onTap: () => !isExpanded
                                  ? BlocProvider.of<WorkoutCubit>(context)
                                      .startWorkout(workout)
                                  : null,
                              visualDensity: const VisualDensity(
                                  horizontal: 0,
                                  vertical: VisualDensity.maximumDensity),
                              leading: IconButton(
                                  onPressed: () =>
                                      BlocProvider.of<WorkoutCubit>(context)
                                          .editWorkout(workout,
                                              workouts.indexOf(workout)),
                                  icon: const Icon(Icons.edit)),
                              title: Text(workout.title!),
                              trailing:
                                  Text(formatTime(workout.getTotal(), true)),
                            )),
                        body: ListView.builder(
                          shrinkWrap: true,
                          itemCount: workout.exercises.length,
                          itemBuilder: (context, index) {
                            final exercise = workout.exercises[index];
                            return ListTile(
                              visualDensity: const VisualDensity(
                                  horizontal: 0,
                                  vertical: VisualDensity.maximumDensity),
                              // leading: IconButton(
                              //     onPressed: () {},
                              //     icon: const Icon(Icons.edit)),
                              leading:
                                  Text(formatTime(exercise.prelude!, true)),
                              trailing:
                                  Text(formatTime(exercise.duration!, true)),
                              title: Text(exercise.title!),
                            );
                          },
                        ));
                  }).toList(),
                ))),
      ),
    );
  }
}
