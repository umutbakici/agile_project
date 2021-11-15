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
          StoreConnector<AppState, String>(
              builder: (context, goldd) {
                return Text("Gold: $goldd");
              },
              converter: (store) => store.state.user.gold.toString()),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(Icons.home)),
        ],
      ),
      body: StoreListview(),
    );
  }
}
