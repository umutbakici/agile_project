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
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/app_setting');
            },
            icon: Icon(Icons.logout)),
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
          SizedBox(
            height: 100,
            child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: CircleAvatar(
                          radius: 20,
                        ),
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
                                StoreConnector<AppState, User>(
                                    builder: (context, user) {
                                      return LinearProgressIndicator(
                                        value: user.XP / 300.0,
                                        backgroundColor:
                                            Color.fromRGBO(0, 0, 0, 1),
                                      );
                                    },
                                    converter: (store) =>
                                        store.state.user ?? User()),
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/mpcreatejoin');
                  },
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
          StoreConnector<AppState, List<String>>(
              builder: (context, nots) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var item in nots)
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
                                      "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png",
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
                                        child: Text("Achievement Completed!",
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
                                                item
                                                    .replaceAll("_", " ")
                                                    .toUpperCase(),
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
                  ],
                );
              },
              converter: (store) => store.state.notifications ?? [])
        ],
      ),
    );
  }
}
