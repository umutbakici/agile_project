import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/actions.dart';
import 'package:agile_project/service/auth.dart';
import 'package:redux/redux.dart';

import 'middlewares.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, UserLoadedAction>(_userLoaded),
  TypedReducer<AppState, RoomUpdatedAction>(_roomUpdated),
  TypedReducer<AppState, TestAction>(_testAction),
  TypedReducer<AppState, NotificationAddAction>(_notificationAdd),
]);

AppState _notificationAdd(AppState as, NotificationAddAction na) {
  print("Notification Add action");
  List<String> new_not = new List<String>.from(as.notifications);
  new_not.add(na.notification);
  return as.copyWith(notifications: new_not);
}

AppState _userLoaded(AppState as, UserLoadedAction action) {
  print("Uderloadaction");
  print("userloaded: ${action.user.toString()}");
  return as.copyWith(user: action.user);
}

AppState _roomUpdated(AppState as, RoomUpdatedAction action) {
  print("Room Update Action Triggered");
  if (action.room.players[0] == as.user.username) {
    // We are host
    if (action.room.gameStatus == "WAIT" && // Game is Wait
        action.room.players.length > 1) {
      print("STARTING GAME");
      store.dispatch(updateRoom(action.room.copyWith(
          gameStatus: "IN PROGRESS"))); // Set room status to IN PROGRESS
      return as;
    }
  }
  return as.copyWith(room: action.room);
}

AppState _testAction(AppState as, TestAction action) {
  print("Test Action Triggered");
  return as;
}
