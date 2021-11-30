import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/actions.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/service/auth.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

ThunkAction<AppState> getUserDataFromFirebase(String email) {
  return (Store<AppState> store) async {
    print("\n\nUSER DATA REQ: $email\n\n");
    final User u = await AuthService().getUserWithEmail(email);
    store.dispatch(new UserLoadedAction(u));
  };
}

ThunkAction<AppState> setInventoryItemCount(String item, int count) {
  return (Store<AppState> store) async {
    var newInventory =
        new Map<String, dynamic>.from(store.state.user.inventory);
    newInventory[item] = count;
    final newUser = store.state.user.copyWith(inventory: newInventory);
    store.dispatch(new UserLoadedAction(newUser));
    await FirebaseFirestore.instance
        .collection("users")
        .doc(store.state.user.username)
        .update({'inventory.$item': count});
  };
}

ThunkAction<AppState> addXP(int xp) {
  return (Store<AppState> store) async {
    final int finalXP = (xp + store.state.user.XP) % 100;
    final int lvlDelta = (xp + store.state.user.XP) ~/ 100;

    final User u = store.state.user
        .copyWith(XP: finalXP, level: store.state.user.level + lvlDelta);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(store.state.user.username)
        .update({'XP': finalXP, 'level': FieldValue.increment(lvlDelta)});
    store.dispatch(new UserLoadedAction(u));
  };
}
