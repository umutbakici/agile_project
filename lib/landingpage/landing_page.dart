import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/models/user.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          //style:
        ),
        backgroundColor: Color(0xFF80D8FF),
        centerTitle: true,
        elevation: 0.0,
        leading: Container(),
        actions: [
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
                //Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      StoreConnector<AppState, User>(
                          builder: (context, name) {
                            return Text(name.username);
                          },
                          converter: (store) => store.state.user ?? User()),
                      SizedBox(
                          width: 100,
                          height: 40,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                StoreConnector<AppState, User>(
                                    builder: (context, user) {
                                      return Text("Level: ${user.level}",
                                          textAlign: TextAlign.left);
                                    },
                                    converter: (store) =>
                                        store.state.user ?? User()),
                                SizedBox(
                                  height: 5,
                                ),
                                LinearProgressIndicator(
                                  value: 0.3,
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                )
                              ]))
                    ])),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/category');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
                    child: Text(
                      'Single Player',
                      //style:
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0xFF80D8FF)),
                ),
              ),
              Expanded(
                flex: 1,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 22.0),
                    child: Text(
                      'Multi Player',
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
