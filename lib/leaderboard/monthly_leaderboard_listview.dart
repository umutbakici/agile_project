import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardListViewMonthly extends StatefulWidget {
  const LeaderboardListViewMonthly({Key key}) : super(key: key);

  @override
  _LeaderboardListViewMonthlyState createState() =>
      _LeaderboardListViewMonthlyState();
}

class _LeaderboardListViewMonthlyState
    extends State<LeaderboardListViewMonthly> {
  List<Widget> getLeaderboardData(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((document) {
      return Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Spacer(flex: 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.data()["user_name"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Level: ${document.data()["level"].toString()}"),
                    Text("Monthly XP: ${document.data()["XP"].toString()}")
                  ],
                ),
                Spacer(flex: 5),
                OutlinedButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed('/');
                    },
                    child: Text('CHALLENGE!',
                        style: TextStyle(
                          color: Color(0xFF80D8FF),
                        ))),
                Spacer(flex: 1),
              ],
            )),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null)
                return Center(child: CircularProgressIndicator());
              else {
                return Expanded(
                    child: ListView(
                  children: getLeaderboardData(snapshot),
                ));
              }
            }),
      ],
    );
  }
}
