import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/actions.dart';
import 'package:agile_project/service/auth.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, UserLoadedAction>(_userLoaded),
  TypedReducer<AppState, TestAction>(_testAction),
]);

AppState _userLoaded(AppState as, UserLoadedAction action) {
  print("Uderloadaction");
  print("userloaded: ${action.user.toString()}");
  return as.copyWith(user: action.user);
}

AppState _testAction(AppState as, TestAction action) {
  print("Test Action Triggered");
  return as;
}
