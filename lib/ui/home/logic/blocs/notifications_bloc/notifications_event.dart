part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class NotificationReceivedEvent extends NotificationsEvent {
  final List<MyNotification> notifications;

  NotificationReceivedEvent({required this.notifications});

  @override
  List<Object?> get props => [notifications];
}
