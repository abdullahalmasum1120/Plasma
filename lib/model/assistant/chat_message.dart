// enum ChatMessageType {
//   text,
//   audio,
//   video,
//   image,
// }
// enum MessageStatus {
//   notSent,
//   notViewed,
//   viewed,
// }

class ChatMessage {
  String? messageType;
  String? messageStatus;
  String? sender;
  String? senderName;
  String? senderProfileImage;
  String? text;
  String? audio;
  String? video;
  String? image;
  String? receiver;
  String? docId;
  String? time;
  String? date;

  ChatMessage(
      {this.messageType,
        this.messageStatus,
        this.sender,
        this.senderName,
        this.senderProfileImage,
        this.text,
        this.audio,
        this.video,
        this.image,
        this.receiver,
        this.docId,
        this.time,
        this.date});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    messageType = json['messageType'];
    messageStatus = json['messageStatus'];
    sender = json['sender'];
    senderName = json['senderName'];
    senderProfileImage = json['senderProfileImage'];
    text = json['text'];
    audio = json['audio'];
    video = json['video'];
    image = json['image'];
    receiver = json['receiver'];
    docId = json['docId'];
    time = json['time'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['messageType'] = messageType;
    data['messageStatus'] = messageStatus;
    data['sender'] = sender;
    data['senderName'] = senderName;
    data['senderProfileImage'] = senderProfileImage;
    data['text'] = text;
    data['audio'] = audio;
    data['video'] = video;
    data['image'] = image;
    data['receiver'] = receiver;
    data['docId'] = docId;
    data['time'] = time;
    data['date'] = date;
    return data;
  }
}