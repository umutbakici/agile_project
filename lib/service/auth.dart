import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User> get authStateCbhanges => _auth.authStateChanges();

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
      _firestore.collection("users").doc(user.user.uid).set({
        "mail": mail,
        "user_name": userName,
      });
      return "Signed up.";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
