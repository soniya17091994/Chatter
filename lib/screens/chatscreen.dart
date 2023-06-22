import 'package:chatter/model/message_model.dart';
import 'package:chatter/providers/chat_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  ChatScreen({super.key, required this.name, required this.uid});
  final String name;
  final String uid;
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatNotifier = ref.watch(chatProvider);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          child: Text(name),
          onTap: () {
            chatNotifier.fetchAllMessage();
          },
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
      chatNotifier.allMessages.isNotEmpty
          ? Positioned(
              top: 0,
              bottom: 100,
              left: 0,
              right: 0,
              child: ListView.builder(
                  itemCount: chatNotifier.allMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatNotifier.allMessages[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text(message.message!),
                          Text(message.senderUid!),
                        ]),
                      ),
                    );
                  }))
          : const Center(
              child: CircularProgressIndicator(),
            ),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: 100,
            color: Colors.blue,
            child: SafeArea(
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 85,
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () async {
                        //send Message to firestore database here
                        if (messageController.text.isEmpty) return;
                        final timestamp =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        final senderUid =
                            FirebaseAuth.instance.currentUser!.uid;
                        MessageModel messageModel = MessageModel(
                            messageController.text,
                            senderUid,
                            uid,
                            timestamp,
                            0);
                        chatNotifier.setMessage(messageModel);
                        await chatNotifier.sendMessage().then((value) {
                          messageController.clear(); }
                        );},
                      icon: Icon(
                        Icons.send,
                        size: 30,
                        color: Colors.white,
                      ),),
                )
              ]),
            ),
          ))
        ],
      ),
    );
  }
}
