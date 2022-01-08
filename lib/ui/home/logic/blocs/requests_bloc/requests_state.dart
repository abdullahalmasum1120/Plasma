part of 'requests_bloc.dart';

abstract class RequestsState extends Equatable {
  const RequestsState();
}

class FetchedDataState extends RequestsState {
  final List<ReceivedRequest> requests;

  FetchedDataState(this.requests);

  @override
  List<Object> get props => [requests];
}
