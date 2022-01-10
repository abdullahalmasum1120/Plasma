part of 'upload_bloc.dart';

abstract class UploadInitialEvent extends Equatable {
  const UploadInitialEvent();
}

class UploadEvent extends UploadInitialEvent {
  final File file;
  final Reference reference;

  UploadEvent(this.file, this.reference);

  @override
  List<Object?> get props => [this.reference, this.file];
}

class UploadedEvent extends UploadInitialEvent {
  final String downloadUrl;

  UploadedEvent(this.downloadUrl);

  @override
  List<Object?> get props => [this.downloadUrl];
}

class UploadingEvent extends UploadInitialEvent {
  final double progress;

  UploadingEvent(this.progress);

  @override
  List<Object?> get props => [this.progress];
}
