part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();
}

class InternetLoading extends InternetState {
  @override
  List<Object> get props => [];
}

class InternetConnected extends InternetState {
  @override
  List<Object> get props => [];
}

class InternetDisConnected extends InternetState {
  @override
  List<Object> get props => [];
}
