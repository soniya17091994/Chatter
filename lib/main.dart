import 'package:chatter/screens/alluserscreen.dart';
import 'package:chatter/firebase_options.dart';
import 'package:chatter/screens/loginscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: ChatterApp()),);
}

class ChatterApp extends StatelessWidget {
  const ChatterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser != null
          ? AllUsersScreen()
          : LoginScreen(),
    );
  }
}
