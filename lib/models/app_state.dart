import 'package:agile_project/models/room.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/reducers/app_state_reducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

Store<AppState> store = Store<AppState>(appReducer,
    initialState: AppState(), middleware: [thunkMiddleware]);

class AppState {
  final bool isLoggedIn;
  final User user;
  final Room room;
  AppState({this.isLoggedIn = false, this.user, this.room});

  AppState copyWith({bool isLoggedIn, User user, Room room}) {
    return AppState(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        user: user ?? this.user,
        room: room ?? this.room);
  }
}
