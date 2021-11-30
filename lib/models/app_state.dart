import 'package:agile_project/models/user.dart';
import 'package:agile_project/reducers/app_state_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

Store<AppState> store = Store<AppState>(appReducer,
    initialState: AppState(), middleware: [thunkMiddleware]);

class AppState {
  final bool isLoggedIn;
  final User user;

  AppState({this.isLoggedIn = false, this.user});

  AppState copyWith({bool isLoggedIn, User user}) {
    return AppState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn, user: user ?? this.user);
  }
}
