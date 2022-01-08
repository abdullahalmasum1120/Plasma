part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  final int duration;

  const TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitialState extends TimerState {
  const TimerInitialState(int duration) : super(duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerPausedState extends TimerState {
  const TimerPausedState(int duration) : super(duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunInProgressState extends TimerState {
  const TimerRunInProgressState(int duration) : super(duration);

  @override
  String toString() => duration.toString();
}

class TimerRunCompleteState extends TimerState {
  const TimerRunCompleteState() : super(0);
}
