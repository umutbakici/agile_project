import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/actions.dart';
import 'package:agile_project/service/auth.dart';
import 'package:redux/redux.dart';

import 'middlewares.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, UserLoadedAction>(_userLoaded),
  TypedReducer<AppState, RoomUpdatedAction>(_roomUpdated),
  TypedReducer<AppState, TestAction>(_testAction),
]);

AppState _userLoaded(AppState as, UserLoadedAction action) {
  print("Uderloadaction");
  print("userloaded: ${action.user.toString()}");
  return as.copyWith(user: action.user);
}

AppState _roomUpdated(AppState as, RoomUpdatedAction action) {
  print("Room Update Action Triggered");
  if (action.room.players[0] == as.user.username && // We are host
      action.room.gameStatus == "WAIT" && // Game is Wait
      action.room.players.length > 1) {
    print("STARTING GAME");
    store.dispatch(updateRoom(action.room.copyWith(gameStatus: "IN PROGRESS")));
    return as;
  }
  return as.copyWith(room: action.room);
}

AppState _testAction(AppState as, TestAction action) {
  print("Test Action Triggered");
  return as;
}
