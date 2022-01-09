part of 'notifications_bloc.dart';


class FetchedNotificationsState extends Equatable {
  final List<MyNotification> notifications;

  FetchedNotificationsState({required this.notifications});

  @override
  List<Object> get props => [notifications];
}
