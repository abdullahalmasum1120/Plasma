part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();
}

class DownloadInitialState extends DownloadState {
  @override
  List<Object> get props => [];
}

class DownloadingState extends DownloadState {
  final int progress;

  DownloadingState(this.progress);

  @override
  List<Object> get props => [progress];
}

class DownloadedState extends DownloadState {
  @override
  List<Object> get props => [];
}
