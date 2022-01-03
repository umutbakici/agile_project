import 'package:agile_project/reducers/middlewares.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/models/app_state.dart' as aps;

class MPJoinPage extends StatefulWidget {
  @override
  _MPJoinPageState createState() => _MPJoinPageState();
}

class _MPJoinPageState extends State<MPJoinPage> {
  Future<void> getRooms() async {
    rooms = await FirebaseFirestore.instance
        .collection('rooms')
        .where("gameStatus", isEqualTo: "WAIT")
        .get()
        .then((s) => s.docs);
    print(rooms.map((e) => e.data()));
  }

  var rooms = [];

  @override
  void initState() {
    super.initState();
    getRooms().then((result) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Join Multiplayer',
          //style:
        ),
        backgroundColor: Color(0xFF80D8FF),
        centerTitle: true,
        elevation: 0.0,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/achievement');
              },
              icon: Icon(Icons.emoji_events_outlined)),
          /*
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/leaderboard');
              },
              icon: Icon(Icons.leaderboard_outlined)),
              */
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/store');
              },
              icon: Icon(Icons.store_outlined)),
          IconButton(
              onPressed: () {
                //TO DO SETTINGS
                Navigator.pushNamed(context, '/profile_setting');
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: List.from(rooms.map((d) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d["category"]),
                      OutlinedButton(
                        onPressed: () {
                          aps.store.dispatch(joinRoom(d["roomID"]));
                          Navigator.pushNamed(context, '/mp_questions',
                              arguments: aps.store.state.room.category);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 22.0),
                          child: Text(
                            'Join Game',
                            //style:
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xFF80D8FF)),
                      ),
                    ],
                  ),
                ))),
          ),
        ],
      ),
    );
  }
}
