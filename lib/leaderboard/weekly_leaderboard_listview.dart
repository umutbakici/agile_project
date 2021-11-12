import 'package:flutter/material.dart';

class LeaderboardListViewWeekly extends StatefulWidget {
  const LeaderboardListViewWeekly({Key key}) : super(key: key);

  @override
  _LeaderboardListViewWeeklyState createState() =>
      _LeaderboardListViewWeeklyState();
}

class _LeaderboardListViewWeeklyState extends State<LeaderboardListViewWeekly> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 15, //User length
            itemBuilder: (BuildContext context, int index) {
              //LeaderboardListItem
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
                          children: [Text('username'), Text("Weekly Score")],
                        ),
                        Spacer(flex: 5),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/leaderboard');
                            },
                            child: Text('CHALLENGE!',
                                style: TextStyle(
                                  color: Color(0xFF80D8FF),
                                ))),
                        Spacer(flex: 1),
                      ],
                    )),
              );
            },
          ),
        )
      ],
    );
  }
}
