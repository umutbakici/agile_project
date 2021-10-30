import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User> get authStateCbhanges => _auth.authStateChanges();

  Future<String> signIn(String mail, String password) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: mail, password: password);
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
