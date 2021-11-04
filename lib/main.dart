import 'package:agile_project/questions/questions_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'leaderboard/leaderboard_screen.dart';
import 'store/store_screen.dart';
import './login-signup/login_screen.dart';
import './login-signup/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    routes: {
      '/': (context) => HomeScreen(),
      '/login': (context) => LoginScreen(),
      '/signup': (context) => SignupScreen(),
      '/questions': (context) => QuestionsScreen(),
      '/store': (context) => StoreScreen(),
      '/leaderboard': (context) => LeaderboardScreen(),
    },
  ));
}
