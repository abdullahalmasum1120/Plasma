class FeaturedImage {
  String? date;
  String? docId;
  String? image;
  String? time;
  String? uid;
  String? username;

  FeaturedImage(
      {this.date, this.docId, this.image, this.time, this.uid, this.username});

  FeaturedImage.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    docId = json['docId'];
    image = json['image'];
    time = json['time'];
    uid = json['uid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['docId'] = docId;
    data['image'] = image;
    data['time'] = time;
    data['uid'] = uid;
    data['username'] = username;
    return data;
  }
}
