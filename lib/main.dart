import 'package:flutter/material.dart';
import './home.dart';

void main() => runApplication(MaterialApp(
      routes: {
        '/': (context) => HomePage(),
        //'/login': (context) => Login(),
        //'/signup': (context) => SignUp(),
      },
    ));
