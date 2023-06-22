class MessageModel {
  String? message;
  String? senderUid;
  String? receiverUid;
  String? timestamp;
  int? type;
  
  MessageModel(
      this.message,
      this.senderUid,
      this.receiverUid,
      this.timestamp,
      this.type);

  //Create a From Json Function
  MessageModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderUid = json['senderUid'];
    receiverUid = json['receiverUid'];
    timestamp = json['timestamp'];
    type = json['type'];
  }
  //create a toJson
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'timestamp': timestamp,
      'type': type
    };
  }
}
