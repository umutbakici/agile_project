import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:agile_project/models/user.dart' as au;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<String>> getUserNames() async {
    List<String> userNames = [];

    try {
      await _firestore
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((elm) {
          userNames.add(elm.data()['user_name']);
        });
      });
      return Future.value(userNames);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signIn(String mail, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: mail, password: password);
      return "Singed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<String> signUp(String mail, String password, String userName) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: mail, password: password);
      _firestore.collection("users").doc(userName).set({
        "mail": mail,
        "user_name": userName,
        "gold": 0,
        "level": 1,
        "XP": 0,
        "pic_url":
            "https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/131654569/original/fd45e2a3d3d1643130922e98b0ce921863b6127a/make-you-cartoon-avatar.jpeg",
        "inventory": {
          "5050": 5,
          "pass": 10,
          "1": 0,
          "2": 0,
          "3": 0,
          "4": 0,
          "5": 0,
          "6": 0,
          "7": 0,
          "8": 0,
          "9": 0
        },
        "stats": {"questions_answered": 0},
        "isAdmin": false,
      });
      return "Signed up.";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<au.User> getUserWithName(String uname) async {
    return await _firestore
        .collection("users")
        .doc(uname)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.exists) {
        au.User u = au.User(
            username: ds.data()["user_name"],
            XP: ds.data()["XP"],
            gold: ds.data()["gold"],
            pic_url: ds.data()["pic_url"],
            level: ds.data()["level"],
            mail: ds.data()["mail"],
            inventory: ds.data()["inventory"],
            stats: ds.data().containsKey("stats")
                ? ds.data()["stats"]
                : {"questions_answered": 0},
            isAdmin: ds.data().containsKey("isAdmin")
                ? ds.data()["isAdmin"]
                : false);

        print("authservice: ${u.toString()}");
        return u;
      }
      return au.User();
    });
  }

  Future<au.User> getUserWithEmail(String email) async {
    return await _firestore
        .collection("users")
        .where('mail', isEqualTo: email)
        .limit(1)
        .get()
        .then((QuerySnapshot qs) {
      final DocumentSnapshot ds = qs.docs.first;
      if (ds.exists) {
        au.User u = au.User(
            username: ds.data()["user_name"],
            XP: ds.data()["XP"],
            gold: ds.data()["gold"],
            pic_url: ds.data()["pic_url"],
            level: ds.data()["level"],
            mail: ds.data()["mail"],
            inventory: ds.data()["inventory"],
            stats: ds.data().containsKey("stats")
                ? ds.data()["stats"]
                : {"questions_answered": 0},
            isAdmin: ds.data().containsKey("isAdmin")
                ? ds.data()["isAdmin"]
                : false);

        print("authservice: ${u.toString()}");
        return u;
      }
      return au.User();
    });
  }
}
