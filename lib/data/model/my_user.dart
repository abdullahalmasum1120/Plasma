class MyUser {
  String? username;
  String? email;
  String? bloodGroup;
  String? location;
  String? image;
  String? registrationTime;
  String? registrationDate;
  int? donated;
  int? requested;
  bool? isAvailable;
  String? phone;
  String? uid;

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
    username = json['username'];
    email = json['email'];
    bloodGroup = json['bloodGroup'];
    location = json['location'];
    image = json['image'];
    registrationTime = json['registrationTime'];
    registrationDate = json['registrationDate'];
    donated = json['donated'];
    requested = json['requested'];
    isAvailable = json['isAvailable'];
    phone = json['phone'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['bloodGroup'] = bloodGroup;
    data['location'] = location;
    data['image'] = image;
    data['registrationTime'] = registrationTime;
    data['registrationDate'] = registrationDate;
    data['donated'] = donated;
    data['requested'] = requested;
    data['isAvailable'] = isAvailable;
    data['phone'] = phone;
    data['uid'] = uid;
    return data;
  }
}
