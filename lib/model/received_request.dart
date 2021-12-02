class ReceivedRequest {
  String? time;
  String? date;
  String? uid;
  String? status;
  String? docId;

  ReceivedRequest({this.time, this.date, this.uid, this.status, this.docId});

  ReceivedRequest.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    date = json['date'];
    uid = json['uid'];
    status = json['status'];
    docId = json['docId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['date'] = date;
    data['uid'] = uid;
    data['status'] = status;
    data['docId'] = docId;
    return data;
  }
}