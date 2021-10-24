import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './home.dart';
import './login-signup/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      '/': (context) => HomePage(),
      '/login': (context) => LoginScreen(),
      //'/signup': (context) => SignUp(),
    },
  ));
}
