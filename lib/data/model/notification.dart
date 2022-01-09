import 'package:equatable/equatable.dart';

class MyNotification extends Equatable {
  late final String? time;
  late final String? date;
  late final String? uid;
  late final String? status;
  late final String? docId;

  MyNotification({this.time, this.date, this.uid, this.status, this.docId});

  MyNotification.fromJson(Map<String, dynamic> json) {
    this.time = json['time'];
    this.date = json['date'];
    this.uid = json['uid'];
    this.status = json['status'];
    this.docId = json['docId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = this.time;
    data['date'] = this.date;
    data['uid'] = this.uid;
    data['status'] = this.status;
    data['docId'] = this.docId;
    return data;
  }

  @override
  List<Object?> get props =>
      [this.time, this.uid, this.date, this.status, this.docId];
}
