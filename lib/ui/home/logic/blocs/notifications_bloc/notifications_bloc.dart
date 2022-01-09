import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blood_donation/data/model/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc
    extends Bloc<NotificationsEvent, FetchedNotificationsState> {
  late StreamSubscription _notificationsStreamSubscription;
  List<MyNotification> notifications = <MyNotification>[];

  NotificationsBloc() : super(FetchedNotificationsState(notifications: [])) {
    _notificationsStreamSubscription = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("receivedRequests")
        .snapshots()
        .listen((snapshot) {
      notifications.clear();
      for (QueryDocumentSnapshot doc in snapshot.docs) {
        notifications
            .add(MyNotification.fromJson(doc.data() as Map<String, dynamic>));
      }
      add(NotificationReceivedEvent(notifications: notifications));
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
