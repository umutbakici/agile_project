import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/actions.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/service/auth.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

ThunkAction<AppState> getUserDataFromFirebase(String uname) {
  return (Store<AppState> store) async {
    final User u = await AuthService().getUserWithName(uname);
    store.dispatch(new UserLoadedAction(u));
  };
}
