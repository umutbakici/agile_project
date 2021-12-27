import 'package:agile_project/category/category_screen.dart';
import 'package:agile_project/service/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/models/user.dart' as au;
import 'package:agile_project/models/app_state.dart' as aps;
import 'package:flutter_redux/flutter_redux.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({Key key}) : super(key: key);

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class Achievement {
  String name;
  String description;
  String image;
  bool locked;

  Achievement({this.name, this.description, this.image});
}

String achievement1 = "Achievement Name";

List<Achievement> Achievements = [
  Achievement(
      name: "In a Hurry!",
      description: "Complete a quiz less than 10 seconds",
      image:
          "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png"),
  Achievement(
      name: "Jack of all trades",
      description: "In random choice, answer all questions correct",
      image:
          "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png"),
  Achievement(
      name: "Unlucky Day",
      description: "In random choice, answer all questions incorrect",
      image:
          "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png"),
  Achievement(
      name: "Online!",
      description: "Play multiplayer mode first time",
      image: "https://icon-library.com/images/lock-icon/lock-icon-10.jpg"),
  Achievement(
      name: "I will win this round",
      description: "Buy jokers from the shop first time",
      image: "https://icon-library.com/images/lock-icon/lock-icon-10.jpg"),
];

class _AchievementScreenState extends State<AchievementScreen> {
  au.User user;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchData().then((result) {
      print("result: $result");
      setState(() {});
    });
  }

  fetchData() async {
    try {
      user = await AuthService()
          .getUserWithEmail(FirebaseAuth.instance.currentUser.email);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    /*WidgetsBinding.instance
        .addPostFrameCallback((_) => achievementNotification(achievement1));
    */
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ACHIEVEMENTS',
            //style:
          ),
          backgroundColor: Color(0xFF80D8FF),
          centerTitle: true,
          elevation: 0.0,
          leading: Container(),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/landing');
                },
                icon: Icon(Icons.home)),
          ],
        ),
        body: Column(children: [
          Expanded(
            child: StoreConnector<aps.AppState, au.User>(
                builder: (context, user) {
                  return ListView(children: <Widget>[
                    for (var item in user.stats.entries)
                      Card(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        elevation: 5,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Spacer(flex: 1),
                                Stack(
                                  children: [
                                    Image.network(
                                      item.value > 10
                                          ? "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png"
                                          : "https://icon-library.com/images/lock-icon/lock-icon-10.jpg",
                                      width: 64,
                                      height: 64,
                                    ),
                                    Container(
                                      color: Colors.black26,
                                      width: 64,
                                      height: 64,
                                    )
                                  ],
                                ),
                                Spacer(flex: 5),
                                Column(
                                  children: [
                                    Center(
                                        child: Text(
                                            "${item.key.replaceAll("_", " ").toUpperCase()}",
                                            style: TextStyle(
                                                color: Color(0xFF00695C),
                                                fontWeight: FontWeight.bold))),
                                    SizedBox(height: 16),
                                    Center(
                                        child: SizedBox(
                                            width: 256,
                                            height: 48,
                                            child: Expanded(
                                              child: Text(
                                                "${item.value > 10 ? 10 * (item.value ~/ 10) : 10 + 10 * (item.value ~/ 10)} ${item.key.replaceAll("_", " ").toUpperCase()}",
                                                style: TextStyle(
                                                  color: Color(0xFF263238),
                                                ),
                                              ),
                                            )))
                                  ],
                                ),
                                Spacer(flex: 1),
                              ],
                            )),
                      )
                  ]);
                },
                converter: (store) =>
                    store.state.user ??
                    au.User()), /*ListView.builder(
              itemCount: Achievements.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Spacer(flex: 1),
                          Stack(
                            children: [
                              Image.network(
                                Achievements[index].image,
                                width: 64,
                                height: 64,
                              ),
                              Container(
                                color: doesContain(Achievements[index].name)
                                    ? Colors.transparent
                                    : Colors.black26,
                                width: 64,
                                height: 64,
                              )
                            ],
                          ),
                          Spacer(flex: 5),
                          Column(
                            children: [
                              Center(
                                  child: Text(Achievements[index].name,
                                      style: TextStyle(
                                          color: Color(0xFF00695C),
                                          fontWeight: FontWeight.bold))),
                              SizedBox(height: 16),
                              Center(
                                  child: SizedBox(
                                      width: 256,
                                      height: 48,
                                      child: Expanded(
                                        child: Text(
                                          Achievements[index].description,
                                          style: TextStyle(
                                            color: Color(0xFF263238),
                                          ),
                                        ),
                                      )))
                            ],
                          ),
                          Spacer(flex: 1),
                        ],
                      )),
                );
              },
            ),*/
          )
        ]));
  }

  doesContain(String achievement) {
    try {
      if (user.achievements.containsValue(achievement)) {
        return true;
      } else {
        return false;
      }
    } catch (Exception) {
      return false;
    }
  }

  achievementNotification(achievement) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 100,
                child: SizedBox(
                    width: 300,
                    child: Center(
                      child: Text(
                        "Congratulations!" +
                            "\n" +
                            achievement.toString() +
                            "\n" +
                            ' Added to profile',
                        style: TextStyle(
                            color: Color(0xFF00695C),
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                margin: EdgeInsets.only(top: 120, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
            ));
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }
}
