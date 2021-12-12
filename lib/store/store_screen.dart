import 'package:agile_project/models/user.dart';
import 'package:agile_project/store/store_listview.dart';
import 'package:agile_project/store/store_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:agile_project/models/app_state.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'STORE',
          //style:
        ),
        backgroundColor: Color(0xFF80D8FF),
        centerTitle: true,
        elevation: 0.0,
        leading: Container(),
        actions: [
          StoreConnector<AppState, User>(
              builder: (context, user) {
                return Text("Gold: ${user.gold}");
              },
              converter: (store) => store.state.user),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/landing');
              },
              icon: Icon(Icons.home)),
        ],
      ),
      body: StoreListview(),
    );
  }
}
