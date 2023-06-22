import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/message_model.dart';

class MessageRepository {
  late FirebaseFirestore firebaseFirestore;

  MessageRepository() {
    firebaseFirestore = FirebaseFirestore.instance;
  }
  
  Future<void> sendMessage(MessageModel message) async {
    log('Sending message: ${message.toJson()}');
    await firebaseFirestore.collection('messages').add(message.toJson());
  }
}
