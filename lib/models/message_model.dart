class MessageModel {
  String senderId;

  MessageModel({this.senderId, this.receiverId, this.text, this.date});

  String receiverId;
  String text;
  String date;

  MessageModel.formJson(Map<String, dynamic> json) {
    senderId = json['userId'];
    receiverId = json['receiverId'];
    text = json['text'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': senderId,
      'receiverId': receiverId,
      'text': text,
      'date': date,
    };
  }
}
