import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  late final String? username;
  late final String? email;
  late final String? bloodGroup;
  late final String? location;
  late final String? image;
  late final String? registrationTime;
  late final String? registrationDate;
  late final int? donated;
  late final int? requested;
  late final bool? isAvailable;
  late final String? phone;
  late final String? uid;

  MyUser(
      {this.username,
      this.email,
      this.bloodGroup,
      this.location,
      this.image,
      this.registrationTime,
      this.registrationDate,
      this.donated,
      this.requested,
      this.isAvailable,
      this.phone,
      this.uid});

  MyUser.fromJson(Map<String, dynamic> json) {
    this.username = json['username'];
    this.email = json['email'];
    this.bloodGroup = json['bloodGroup'];
    this.location = json['location'];
    this.image = json['image'];
    this.registrationTime = json['registrationTime'];
    this.registrationDate = json['registrationDate'];
    this.donated = json['donated'];
    this.requested = json['requested'];
    this.isAvailable = json['isAvailable'];
    this.phone = json['phone'];
    this.uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = this.username;
    data['email'] = this.email;
    data['bloodGroup'] = this.bloodGroup;
    data['location'] = this.location;
    data['image'] = this.image;
    data['registrationTime'] = this.registrationTime;
    data['registrationDate'] = this.registrationDate;
    data['donated'] = this.donated;
    data['requested'] = this.requested;
    data['isAvailable'] = this.isAvailable;
    data['phone'] = this.phone;
    data['uid'] = this.uid;
    return data;
  }

  @override
  List<Object?> get props => [
        this.username,
        this.email,
        this.bloodGroup,
        this.location,
        this.image,
        this.registrationDate,
        this.registrationTime,
        this.donated,
        this.requested,
        this.isAvailable,
        this.phone,
        this.uid
      ];
}
