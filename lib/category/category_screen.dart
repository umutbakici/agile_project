import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

final firestore = FirebaseFirestore.instance;
var lastCategory = [];

class _CategoryScreenState extends State<CategoryScreen> {
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
                              Navigator.of(context).pushNamed('/questions',
                                  arguments: e.toString());
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
