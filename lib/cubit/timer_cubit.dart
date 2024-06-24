import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubitState {
  final int milliseconds;
  final bool isRunning;

  TimerCubitState(this.milliseconds, this.isRunning);
}

class TimerCubit extends Cubit<TimerCubitState> {
  final Stopwatch _stopwatch = Stopwatch();
  late Timer _timer;

  TimerCubit() : super(TimerCubitState(0, false));

  void startStopwatch() {
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        emit(TimerCubitState(
            _stopwatch.elapsedMilliseconds, _stopwatch.isRunning));
      });
    }
  }

  void toggleStopwatch() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
    } else {
      _stopwatch.start();
    }
    emit(TimerCubitState(_stopwatch.elapsedMilliseconds, _stopwatch.isRunning));
  }

  void resetStopwatch() {
    _stopwatch.reset();
    if (!_stopwatch.isRunning) {
      _stopwatch.start();
    }
    emit(TimerCubitState(0, _stopwatch.isRunning));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
