import 'dart:developer';
import 'package:chatter/screens/alluserscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}
  @override
  class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: 50),
        Center(
          child: Text(
            "Register with Chatter",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: 'Enter your Name',
                labelText: 'Enter your Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Enter your Email ID',
              labelText: 'Enter your Email ID',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        InkWell(
          child: isLoading? Center(child: CircularProgressIndicator(),): Container(
            height: 50,
            width: 250,
            child: Center(
                child: Text(
              'Register',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.blue,
            ),
          ),
          onTap: () async=>
            registerNewUserToFirebaseWithEmailAndPassword(context),
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 20),
              GestureDetector(
                child: Text("Login Here",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
void registerNewUserToFirebaseWithEmailAndPassword(
      BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final email = emailController.text;
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      log("Email and password cannot be empty");
      return;
    } else {
      // Create user here
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        final user = value.user;
        if (user != null) {
          addUsersDataToFirestoreDb(user.uid, context);
        }
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        log("User creation failed: $error");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User creation failed")));
      });
    }
  }

  void addUsersDataToFirestoreDb(String uid, BuildContext context) {
    var data = {
      "email": emailController.text,
      "name": nameController.text,
      "password": passwordController.text,
      "uid": uid,
      "createdOn": DateTime.now().millisecondsSinceEpoch.toString(),
    };

    FirebaseFirestore.instance.collection('users').add(data).then((value) {
      log("User added to firestore db successfully");
      // Navigate to home screen
      setState(() {
        isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => AllUsersScreen()),
          (route) => false);
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      log("Failed to add user to firestore db: $error");
    });
  }
}
  

