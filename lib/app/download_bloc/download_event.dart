part of 'download_bloc.dart';

abstract class DownloadEvent extends Equatable {
  const DownloadEvent();
}

class DownloadingEvent extends DownloadEvent {
  final int progress;

  DownloadingEvent(this.progress);

  @override
  List<Object?> get props => [progress];
}

class DownloadStartEvent extends DownloadEvent {
  final Reference reference;

  DownloadStartEvent(this.reference);

  @override
  List<Object?> get props => [reference];
}

class DownloadedEvent extends DownloadEvent {
  @override
  List<Object?> get props => [];
}
