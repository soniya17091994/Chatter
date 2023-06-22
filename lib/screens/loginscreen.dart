import 'package:chatter/screens/alluserscreen.dart';
import 'package:chatter/providers/auth_provider.dart';
import 'package:chatter/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authProvider);
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 100,
        ),
        Center(
          child: Text(
            "Welcome to Chatter",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            controller: emailcontroller,
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
            controller: passwordcontroller,
            decoration: InputDecoration(
              hintText: 'Enter your password',    
              labelText: 'Enter your password',
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
          child: Container(
            height: 50,
            width: 250,
            child: authNotifier.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                : Center(
                    child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.blue,
            ),
          ),
          onTap: () async {
            if (emailcontroller.text.isEmpty ||
                passwordcontroller.text.isEmpty) {
              authNotifier.setErrorText("Please enter Email and Password");
              return;
            }
            authNotifier.setEmail(emailcontroller.text);
            authNotifier.setPassword(passwordcontroller.text);
            await authNotifier.loginUser().then((value) {
              SnackBar snackBar = SnackBar(
                content: Text(
                  authNotifier.errorText,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor:
                    authNotifier.isError ? Colors.red[200] : Colors.green[600],
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
            !authNotifier.isError
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AllUsersScreen()))
                : null;
          },
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
                "Don't have an account?",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 20),
              GestureDetector(
                child: Text("Sign Up",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignUpPage()));
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
