import 'package:flutter/material.dart';

class ExerciseDetails extends StatelessWidget {
  final String? currentExerciseTitle;
  final String? nextExerciseTitle;
  final bool isPrelude;
  const ExerciseDetails({
    Key? key,
    required this.currentExerciseTitle,
    required this.nextExerciseTitle,
    required this.isPrelude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            isPrelude ? 'Get Ready!!' : 'NOW : $currentExerciseTitle',
            style: const TextStyle(color: Colors.red, fontSize: 22),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: nextExerciseTitle != null && isPrelude
              ? Text(
                  'NEXT : $currentExerciseTitle',
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                )
              : Text(
                  'NEXT : $nextExerciseTitle',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
        ),
      ],
    );
  }
}


    //  Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Text(
    //                 stats['isPrelude']
    //                     ? 'Get Ready!!'
    //                     : 'NOW : ${stats['currentExerciseTitle']}',
    //                 style: const TextStyle(color: Colors.red, fontSize: 22),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: stats['nextExerciseTitle'] != null &&
    //                       stats['isPrelude']
    //                   ? Text(
    //                       'NEXT : ${stats['currentExerciseTitle']}',
    //                       style:
    //                           const TextStyle(color: Colors.red, fontSize: 22),
    //                     )
    //                   : Text(
    //                       'NEXT : ${stats['nextExerciseTitle']}',
    //                       style:
    //                           const TextStyle(color: Colors.red, fontSize: 22),
    //                     ),
    //             ),