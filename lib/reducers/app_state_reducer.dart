import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/actions.dart';
import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, SetCurrentUserAction>(_setCurrentUser),
]);

AppState _setCurrentUser(AppState as, SetCurrentUserAction action) {
  return as.copyWith(username: "iki");
}
