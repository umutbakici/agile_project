import 'package:agile_project/questions/questions_page.dart';
import 'package:flutter/material.dart';
import 'models/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'home_screen.dart';
import 'leaderboard/leaderboard_screen.dart';
import 'store/store_screen.dart';
import './login-signup/login_screen.dart';
import 'package:redux/redux.dart';
import './login-signup/signup_screen.dart';

class ReduxApp extends StatelessWidget {
  final Store<AppState> store;

  const ReduxApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        routes: {
          '/': (context) => HomeScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/questions': (context) => QuestionsScreen(),
          '/store': (context) => StoreScreen(),
          '/leaderboard': (context) => LeaderboardScreen(),
        },
      ),
    );
  }
}
