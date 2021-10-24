import 'package:flutter/material.dart';
import './home.dart';
import './login-signup/login_screen.dart';

void main() => runApp(MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginScreen(),
        //'/signup': (context) => SignUp(),
      },
    ));
