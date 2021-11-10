import 'package:agile_project/leaderboard/leaderboard_listview.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key key}) : super(key: key);

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

bool secondaryColorSelectedDaily = true;
bool secondaryColorSelectedWeekly = false;
bool secondaryColorSelectedMonthly = false;

String leaderboardState = 'daily';

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LEADERBOARD',
          //style:
        ),
        backgroundColor: Color(0xFF80D8FF),
        centerTitle: true,
        elevation: 0.0,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.home)),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              dailyInputChip('Daily', Color(0xFF26C6DA)),
              weeklyInputChip('Weekly', Color(0xFF26C6DA)),
              monthlyInputChip('Monthly', Color(0xFF26C6DA)),
            ],
          ),
          Expanded(
              child: leaderboardState == 'daily'
                  ? LeaderboardListView()
                  : leaderboardState == 'weekly'
                      ? Text('WEEKLY SCORES')
                      : leaderboardState == 'monthly'
                          ? Text('MONTHLY SCORES')
                          : Center())
        ],
      ),
    );
  }

  Widget dailyInputChip(String title, Color color) {
    return ChoiceChip(
      label: Text(title),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      backgroundColor: color.withAlpha(128),
      selectedColor: color,
      elevation: 6,
      shadowColor: color.withAlpha(200),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          title[0].toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
      selected: secondaryColorSelectedDaily,
      onSelected: (bool selected) {
        setState(() {
          leaderboardState = 'daily';
          secondaryColorSelectedDaily = true;
          secondaryColorSelectedWeekly = false;
          secondaryColorSelectedMonthly = false;
        });
      },
    );
  }

  Widget weeklyInputChip(String title, Color color) {
    return ChoiceChip(
      label: Text(title),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      backgroundColor: color.withAlpha(128),
      selectedColor: color,
      elevation: 6,
      shadowColor: color.withAlpha(200),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          title[0].toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
      selected: secondaryColorSelectedWeekly,
      onSelected: (bool selected) {
        setState(() {
          leaderboardState = 'weekly';
          secondaryColorSelectedWeekly = true;
          secondaryColorSelectedDaily = false;
          secondaryColorSelectedMonthly = false;
        });
      },
    );
  }

  Widget monthlyInputChip(String title, Color color) {
    return ChoiceChip(
      label: Text(title),
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      labelPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      backgroundColor: color.withAlpha(128),
      selectedColor: color,
      elevation: 6,
      shadowColor: color.withAlpha(200),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: Text(
          title[0].toUpperCase(),
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
      selected: secondaryColorSelectedMonthly,
      onSelected: (bool selected) {
        setState(() {
          leaderboardState = 'monthly';
          secondaryColorSelectedMonthly = true;
          secondaryColorSelectedWeekly = false;
          secondaryColorSelectedDaily = false;
        });
      },
    );
  }
}
