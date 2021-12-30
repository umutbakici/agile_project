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
              Container(
                height: 150,
                color: Colors.lightBlueAccent,
                child: Row(
                  children: [
                    Spacer(
                      flex: 1,
                    ),
                    SizedBox(
                      height: 64,
                      width: 128,
                      child: Text(
                        e.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[200],
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/questions', arguments: e.toString());
                        print("clicked ${e.toString()}");
                      },
                      icon: Icon(Icons.play_arrow_outlined, size: 20),
                      label: Text(
                        "PLAY",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
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
        body: Scaffold(
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
        ])));
  }
}
