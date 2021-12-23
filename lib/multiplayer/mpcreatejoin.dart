import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/models/user.dart';

class MPCreateJoinPage extends StatefulWidget {
  @override
  _MPCreateJoinPageState createState() => _MPCreateJoinPageState();
}

class _MPCreateJoinPageState extends State<MPCreateJoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Multiplayer',
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
            children: [
              SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/categorymp');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
                    child: Text(
                      'Create Game',
                      //style:
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFF80D8FF)),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/joinmp');
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
