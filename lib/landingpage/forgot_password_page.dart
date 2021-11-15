import 'package:agile_project/login-signup/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Enter your e-mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18))),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50),
            child: ElevatedButton(
              child: Container(
                color: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                child: Text(
                  "Reset Password",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance
                    .sendPasswordResetEmail(email: emailController.text)
                    .then((value) {
                  Navigator.pushNamed(context, '/login');
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
