import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku/cubit/timer_cubit.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({super.key});

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Time"),
        BlocBuilder<TimerCubit, TimerCubitState>(
          builder: (context, state) {
            return Text(
              _formatTime(state.milliseconds),
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700),
            );
          },
        ),
      ],
    );
  }
}
