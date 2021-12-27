import 'dart:math';

import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/models/room.dart';
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

ThunkAction<AppState> incUserStat(String stat, int count) {
  return (Store<AppState> store) async {
    var newStats = new Map<String, dynamic>.from(store.state.user.stats);
    if (newStats.containsKey(stat))
      newStats[stat] += count;
    else
      newStats[stat] = count;
    final newUser = store.state.user.copyWith(stats: newStats);
    store.dispatch(new UserLoadedAction(newUser));
    if (newStats[stat] % 10 == 0) {
      store.dispatch(achievementCompleted(stat, newStats[stat]));
    }
    await FirebaseFirestore.instance
        .collection("users")
        .doc(store.state.user.username)
        .update({'stats.$stat': newStats[stat]});
  };
}

ThunkAction<AppState> achievementCompleted(String name, int count) {
  return (Store<AppState> store) async {
    print("\n\nAchievement $name $count completed!\n\n");
  };
}

ThunkAction<AppState> createRoom(String category) {
  return (Store<AppState> store) async {
    var r = Room(
        category: category,
        roomID: getRandomString(15),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        players: [store.state.user.username]);
    print("$r");
    store.dispatch(new RoomUpdatedAction(r));
    await FirebaseFirestore.instance
        .collection("rooms")
        .doc(r.roomID)
        .set(r.toMap());
    Stream documentStream = FirebaseFirestore.instance
        .collection('rooms')
        .doc(r.roomID)
        .snapshots();
    documentStream.listen((event) {
      Room r = Room(
          createdAt: event.data()["createdAt"],
          category: event.data()["category"],
          gameStatus: event.data()["gameStatus"],
          players: event.data()["players"],
          guestScore: event.data()["guestScore"],
          hostScore: event.data()["hostScore"],
          roomID: event.data()["roomID"]);

      store.dispatch(new RoomUpdatedAction(r));
    });
  };
}

ThunkAction<AppState> joinRoom(String roomID) {
  return (Store<AppState> store) async {
    Stream documentStream =
        FirebaseFirestore.instance.collection('rooms').doc(roomID).snapshots();
    documentStream.listen((event) {
      Room r = Room(
          createdAt: event.data()["createdAt"],
          category: event.data()["category"],
          gameStatus: event.data()["gameStatus"],
          players: event.data()["players"],
          guestScore: event.data()["guestScore"],
          hostScore: event.data()["hostScore"],
          roomID: event.data()["roomID"]);
      store.dispatch(new RoomUpdatedAction(r));
    });
    await FirebaseFirestore.instance.collection('rooms').doc(roomID).update({
      'players': FieldValue.arrayUnion([store.state.user.username])
    });
  };
}

ThunkAction<AppState> updateRoom(Room r) {
  return (Store<AppState> store) async {
    await FirebaseFirestore.instance
        .collection("rooms")
        .doc(r.roomID)
        .set(r.toMap());
  };
}

ThunkAction<AppState> addXPGold(int xp, int gold) {
  return (Store<AppState> store) async {
    final int finalXP = (xp + store.state.user.XP) % 300;
    final int lvlDelta = (xp + store.state.user.XP) ~/ 300;
    final int totalGold = gold + store.state.user.gold;
    final User u = store.state.user.copyWith(
        XP: finalXP, level: store.state.user.level + lvlDelta, gold: totalGold);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(store.state.user.username)
        .update({
      'XP': finalXP,
      'level': FieldValue.increment(lvlDelta),
      'gold': totalGold
    });
    store.dispatch(new UserLoadedAction(u));
  };
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
