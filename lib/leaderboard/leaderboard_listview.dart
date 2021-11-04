import 'package:flutter/material.dart';
import 'leaderboard_listitem.dart';

class LeaderboardListView extends StatefulWidget {
  const LeaderboardListView({Key key}) : super(key: key);

  @override
  _LeaderboardListViewState createState() => _LeaderboardListViewState();
}

class _LeaderboardListViewState extends State<LeaderboardListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 15, //User length
            itemBuilder: (BuildContext context, int index) {
              return LeaderboardListItem();
            },
          ),
        )
      ],
    );
  }
}
