import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/model/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  late StreamSubscription _notificationsStreamSubscription;
  List<Notification> notifications = [];

  NotificationsBloc() : super(FetchedNotificationsState(notifications: [])) {
    _notificationsStreamSubscription = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("notifications")
        .snapshots()
        .listen((snapshot) {
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        //TODO: notifications.add();
      }
    });
    on<NotificationReceivedEvent>((event, emit) {
      emit(FetchedNotificationsState(notifications: event.notifications));
    });
  }

  @override
  Future<void> close() {
    _notificationsStreamSubscription.cancel();
    return super.close();
  }
}
