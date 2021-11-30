import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/questions/questions_page.dart';
import 'package:agile_project/reducers/app_state_reducer.dart';
import 'package:agile_project/reducers/middlewares.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final store = Store<AppState>(appReducer,
      initialState: AppState(), middleware: [thunkMiddleware]);
  runApp(ReduxApp(store: store));
}
