import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Level {
  static int getRequirdedXP(int lvl) {
    return lvl * 100;
  }

  static Future<bool> isXPEnough(String userName) async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot userQuerySnapshot) => {
              userQuerySnapshot.docs.forEach((user) {
                int userXP = user.data()['XP'];
                int userLvl = user.data()['level'];
                if (userName == user.data()['user_name'] &&
                    userXP >= Level.getRequirdedXP(userLvl)) {
                  return true;
                }
              })
            });
    return false;
  }

  static void addLevel(String userName) async {
    try {
      Map<String, dynamic> userData;

      await FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot userQuerySnapshot) => {
                userQuerySnapshot.docs.forEach((user) {
                  if (userName == user.data()['user_name']) {
                    userData['user_name'] = userName;
                    userData['gold'] = user.data()['gold'];
                    userData['mail'] = user.data()['mail'];
                    userData['XP'] = user.data()['XP'] -
                        Level.getRequirdedXP(user.data()['XP']);
                    userData['level'] = user.data()['level'] + 1;
                  }
                })
              });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userName)
          .set(userData);
    } catch (e) {
      print(e);
    }
  }
}
