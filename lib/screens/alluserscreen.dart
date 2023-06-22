import 'package:chatter/screens/chatscreen.dart';
import 'package:chatter/screens/loginscreen.dart';
import 'package:chatter/providers/chat_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllUsersScreen extends ConsumerStatefulWidget {
  const AllUsersScreen({super.key});

  @override
  ConsumerState<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends ConsumerState<AllUsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() async {
      await ref.read(chatProvider).fetchAllUsers();
    });
  }

  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, chil) {
      final chatNotifier = ref.watch(chatProvider);
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Chat App",
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen()),
                      (route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: chatNotifier.allUsers != null && chatNotifier.allUsers.isNotEmpty
            ? ListView.builder(
                itemCount: chatNotifier.allUsers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatScreen(
                                name: chatNotifier.allUsers[index].name!,
                                uid: chatNotifier.allUsers[index].uid!))),
                    child: Card(
                      elevation: 1,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(chatNotifier.allUsers[index].name!),
                        ),
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      );
    }
    );
  }
}


