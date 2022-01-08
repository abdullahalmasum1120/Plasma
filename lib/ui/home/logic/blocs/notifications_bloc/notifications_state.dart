part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class FetchedNotificationsState extends NotificationsState {
  final List<Notification> notifications;

  FetchedNotificationsState({required this.notifications});

  @override
  List<Object> get props => [notifications];
}
