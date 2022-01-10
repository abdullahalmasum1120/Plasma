import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_event.dart';

part 'upload_state.dart';

class UploadBloc extends Bloc<UploadInitialEvent, UploadState> {
  late StreamSubscription _fileStreamSubscription;

  UploadBloc() : super(UploadInitialState()) {
    on<UploadEvent>((event, emit) {
      UploadTask _uploadTask = event.reference.putFile(event.file);
      _uploadTask.whenComplete(() async {
        add(UploadedEvent(await event.reference.getDownloadURL()));
      });
      _fileStreamSubscription =
          _uploadTask.snapshotEvents.listen((taskSnapshot) {
        add(UploadingEvent(
            (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes) * 100));
      });
      on<UploadingEvent>((event, emit) {
        emit(UploadingState(event.progress.ceilToDouble()));
      });
      on<UploadedEvent>((event, emit) {
        emit(UploadedState(event.downloadUrl));
      });
    });
  }

  @override
  Future<void> close() {
    _fileStreamSubscription.cancel();
    return super.close();
  }
}
