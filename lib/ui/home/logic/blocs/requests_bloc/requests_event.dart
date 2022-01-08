part of 'requests_bloc.dart';

abstract class RequestsEvent extends Equatable {
  const RequestsEvent();
}

class FetchRequestEvent extends RequestsEvent {
  final int limit;
  final ReceivedRequest? lastRequest;

  FetchRequestEvent({
    this.limit = 2,
    this.lastRequest,
  });

  @override
  List<Object?> get props => [];
}
