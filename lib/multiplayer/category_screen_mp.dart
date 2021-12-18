import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/reducers/middlewares.dart';
import 'package:agile_project/models/app_state.dart' as aps;

class CategoryScreenMP extends StatefulWidget {
  const CategoryScreenMP({Key key}) : super(key: key);

  @override
  _CategoryScreenMPState createState() => _CategoryScreenMPState();
}

final firestore = FirebaseFirestore.instance;
var lastCategory = [];

class _CategoryScreenMPState extends State<CategoryScreenMP> {
  void categoryListMaker(AsyncSnapshot snapshot) {
    return snapshot.data.docs.map<Widget>((document) {
      if (!lastCategory.contains(document.get('category'))) {
        lastCategory.add(document.get('category'));
      }
    }).toList();
  }

  List<Widget> getList() {
    List<Widget> categories = lastCategory
        .map((e) => Column(children: <Widget>[
              Card(
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
                          children: [Text(e.toString())],
                        ),
                        Spacer(flex: 5),
                        OutlinedButton(
                            onPressed: () {
                              aps.store.dispatch(createRoom(e.toString()));
                              Navigator.pushNamed(context, '/waitmp');
                              print("clicked ${e.toString()}");
                            },
                            child: Text('PLAY',
                                style: TextStyle(
                                  color: Color(0xFF80D8FF),
                                ))),
                        Spacer(flex: 1),
                      ],
                    )),
              )
            ]))
        .toList();
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'CATEGORY',
          ),
          backgroundColor: Color(0xFF80D8FF),
          centerTitle: true,
          elevation: 0.0,
          leading: Container(),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/questions');
                },
                icon: Icon(Icons.play_arrow)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/landing');
                },
                icon: Icon(Icons.home)),
          ],
        ),
        body: Column(children: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("questions")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null)
                  return Center(child: CircularProgressIndicator());
                else {
                  categoryListMaker(snapshot);
                  return Expanded(
                      child: ListView(
                    children: getList(),
                  ));
                }
              }),
        ]));
  }
}
