import 'package:agile_project/leaderboard/leaderboard_listitem.dart';
import 'package:agile_project/leaderboard/leaderboard_listview.dart';
import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key key}) : super(key: key);

  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

bool secondaryColorSelected = false;

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
              myInputChip('Daily', Color(0xFF26C6DA)),
              myInputChip('Monthly', Color(0xFF26C6DA)),
              myInputChip('Yearly', Color(0xFF26C6DA)),
            ],
          ),
          Expanded(child: LeaderboardListView())
        ],
      ),
    );
  }

  Widget myInputChip(String title, Color color) {
    return InputChip(
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
      selected: secondaryColorSelected,
      onSelected: (bool selected) {
        setState(() {
          secondaryColorSelected = selected;
          if (secondaryColorSelected) {
            //colors.primaryAppColor = AppColors.secondaryAppColor;
          } else {
            //AppColors.primaryAppColor = const Color(0xFF26C6DA);
          }
        });
      },
    );
  }
}
