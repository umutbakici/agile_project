import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';
import '../models/user.dart';

class ProfileSetting extends StatelessWidget {
  //const ProfileSetting({key}) : super(key: key);
  var _textController = new TextEditingController();
  String userName;
  final _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();


  String handleUserName(String value) {
    if (value == null) {
      return "You need to enter a user name!";
    }
    if (value.length < 6) {
      return "Your user name needs to be at least 6 characters long!";
    }

    bool isNameExists = false;
//    userNames.forEach((userName) {
//      if (value == userName) {
//        isNameExists = true;
    //     }
    //   });
    if (isNameExists) {
      return "Username already exists";
    }

    return null;
  }


  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: new Text("Profile Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          // child: Form(
          child: Column(
            children: <Widget>[
              Text(
                'Change Your Name',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30.0,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 25,
              ),
              Form(
                  key: _formKey,
                  child:
              Column(
                children: [
                  TextFormField(
                    controller: _textController,
                    keyboardType: TextInputType.name,
                    onChanged: (text) => userName = text,
                    validator: handleUserName,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child:
                    MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
//                          StreamBuilder<QuerySnapshot>(
//                              stream: users,
//                              builder: (BuildContext context,
//                                  AsyncSnapshot<QuerySnapshot> snapshot) {
//                                final data = snapshot.requireData;
//                                return
//                                    StoreConnector<AppState, User>(
//                                        // ignore: missing_return
//                                        builder: (context, name) {
//                                          FirebaseFirestore.instance.collection('users').doc(name.username).update({'user_name' : userName});
//                                          Navigator.pushNamed(context, '/profile');
//                                        },
//                                        converter: (store) => store.state.user ?? User());
//                              });
                          FirebaseFirestore.instance.collection('users').doc("sasmazmert").update({'user_name' : userName});
                          Navigator.pushNamed(context, '/profile');
                          }
                          try {
                          } catch (e) {}
                        },
                      color: Colors.blue,
                      child: Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )

              ),


              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.black,
                height: 30,
              ),
              Divider(height: 30),
              Expanded(child: pictures()),
            ],
          ),
          //   ),
        ),
      ),
    );
  }

  var listItems = [
    StoreConnector<AppState, User>(
        // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['1'] != 0) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.bounceOut,
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/131654569/original/fd45e2a3d3d1643130922e98b0ce921863b6127a/make-you-cartoon-avatar.jpeg'),
                child: GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(name.username)
                        .update({
                      'pic_url':
                          'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/131654569/original/fd45e2a3d3d1643130922e98b0ce921863b6127a/make-you-cartoon-avatar.jpeg'
                    });
                  },
                ),
              ),
            );
          } else {
            return Container(
              color: Colors.lightBlueAccent,
            );
          }
        },
        converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
  // ignore: missing_return
  builder: (context, name) {
    if (name.inventory['2'] != 0) {
      return Container(
        color: Colors.lightBlueAccent,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://t4.ftcdn.net/jpg/02/45/28/17/360_F_245281783_3zeOLu7mhjUmYbFlBwSNsfwQmQZzukWo.jpg'
          ),
          child: GestureDetector(onTap: () {
            FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://t4.ftcdn.net/jpg/02/45/28/17/360_F_245281783_3zeOLu7mhjUmYbFlBwSNsfwQmQZzukWo.jpg'});
          },),
        ),
      );
    // ignore: missing_return
    }else{
      return Container(
        color: Colors.lightBlueAccent,
      );}
  }, converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
      // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['3'] != 0) {
            return Container(
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.kindpng.com/picc/m/24-248442_female-user-avatar-woman-profile-member-user-profile.png'
                ),
                child: GestureDetector(onTap: () {
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://www.kindpng.com/picc/m/24-248442_female-user-avatar-woman-profile-member-user-profile.png'});
                },),
              ),
            );
            // ignore: missing_return
          }else{
            return Container(
              color: Colors.lightBlueAccent,
            );}
        }, converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
      // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['4'] != 0) {
            return Container(
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/businessman-icon-v…on-vector-male-avatar-profile-image-182095609.jpg'
                ),
                child: GestureDetector(onTap: () {
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://thumbs.dreamstime.com/b/businessman-icon-v…on-vector-male-avatar-profile-image-182095609.jpg'});
                },),
              ),
            );
            // ignore: missing_return
          }else{
            return Container(
              color: Colors.lightBlueAccent,
            );}
        }, converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
      // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['5'] != 0) {
            return Container(
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.shareicon.net/data/256x256/2016/05/26/771188_man_512x512.png'
                ),
                child: GestureDetector(onTap: () {
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://www.shareicon.net/data/256x256/2016/05/26/771188_man_512x512.png'});
                },),
              ),
            );
            // ignore: missing_return
          }else{
            return Container(
              color: Colors.lightBlueAccent,
            );}
        }, converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
      // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['6'] != 0) {
            return Container(
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://stanforduni.us/wp-content/uploads/2020/05/default-avatar.png'
                ),
                child: GestureDetector(onTap: () {
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://stanforduni.us/wp-content/uploads/2020/05/default-avatar.png'});
                },),
              ),
            );
            // ignore: missing_return
          }else{
            return Container(
              color: Colors.lightBlueAccent,
            );}
        }, converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
      // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['7'] != 0) {
            return Container(
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.shareicon.net/data/256x256/2016/05/24/770121_man_512x512.png'
                ),
                child: GestureDetector(onTap: () {
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://www.shareicon.net/data/256x256/2016/05/24/770121_man_512x512.png'});
                },),
              ),
            );
            // ignore: missing_return
          }else{
            return Container(
              color: Colors.lightBlueAccent,
            );}
        }, converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
      // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['8'] != 0) {
            return Container(
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://homevest.com/wp-content/uploads/2019/05/female1-512.png'
                ),
                child: GestureDetector(onTap: () {
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://homevest.com/wp-content/uploads/2019/05/female1-512.png'});
                },),
              ),
            );
            // ignore: missing_return
          }else{
            return Container(
              color: Colors.lightBlueAccent,
            );}
        }, converter: (store) => store.state.user ?? User()),
    StoreConnector<AppState, User>(
      // ignore: missing_return
        builder: (context, name) {
          if (name.inventory['9'] != 0) {
            return Container(
              color: Colors.lightBlueAccent,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.pngitem.com/pimgs/m/0-6243_user-profile-avatar-scalable-vector-graphics-icon-woman.png'
                ),
                child: GestureDetector(onTap: () {
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'pic_url' : 'https://www.pngitem.com/pimgs/m/0-6243_user-profile-avatar-scalable-vector-graphics-icon-woman.png'});
                },),
              ),
            );
            // ignore: missing_return
          }else{
            return Container(
              color: Colors.lightBlueAccent,
            );}
        }, converter: (store) => store.state.user ?? User()),
  ];

  Widget pictures() => GridView.count(
    crossAxisSpacing: 15,
    mainAxisSpacing: 20,
    crossAxisCount: 3,
    padding: EdgeInsets.all(8),
    children: listItems,
  );
}

