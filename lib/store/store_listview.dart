import 'package:agile_project/store/store_tile.dart';
import 'package:flutter/material.dart';

class StoreListview extends StatefulWidget {
  const StoreListview({Key key}) : super(key: key);

  @override
  _StoreListviewState createState() => _StoreListviewState();
}

class _StoreListviewState extends State<StoreListview> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: 6, //StoreList.length,
          itemBuilder: (BuildContext context, int index) {
            return StoreTile();
          },
        ),
      )
    ]);
  }
}
