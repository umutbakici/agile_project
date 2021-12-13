import 'package:agile_project/reducers/middlewares.dart';
import 'package:agile_project/store/store_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/app_state.dart';
import '../models/user.dart';

class StoreListview extends StatefulWidget {
  const StoreListview({Key key}) : super(key: key);

  @override
  _StoreListviewState createState() => _StoreListviewState();
}

class _StoreListviewState extends State<StoreListview> {
  @override
  Widget build(BuildContext context) {

    final Stream<QuerySnapshot> users = FirebaseFirestore.instance.collection('users').snapshots();

    return Column(children: [
      Expanded(
        child: pictures(),
      ),
    ]);
  }

  var listItems = [
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://tridacmortgages.com/wp-content/uploads/2011/09/5050_logo.png'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.gold>50){
                  FirebaseFirestore.instance.collection('users').doc(name.username).set({'gold' : (name.gold-50),
                    'XP':name.XP,'level':name.level,'mail':name.mail,'pic_url':name.pic_url,'user_name':name.username,
                    'inventory':name.inventory});
                 // FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-50)});
                  store.dispatch(setInventoryItemCount("50/50", (name.inventory['50/50']+1)));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "50 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://thumbs.dreamstime.com/b/pass-text-red-grungy-vintage-round-stamp-rubber-205333260.jpg'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.gold>50){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-50)});
                  store.dispatch(setInventoryItemCount("pass", (name.inventory['pass']+1)));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "50 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/131654569/original/fd45e2a3d3d1643130922e98b0ce921863b6127a/make-you-cartoon-avatar.jpeg'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['1']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("1", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
                print(name.inventory['1']);
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
            converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://t4.ftcdn.net/jpg/02/45/28/17/360_F_245281783_3zeOLu7mhjUmYbFlBwSNsfwQmQZzukWo.jpg'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['2']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("2", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://www.kindpng.com/picc/m/24-248442_female-user-avatar-woman-profile-member-user-profile.png'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['3']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("3", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://thumbs.dreamstime.com/b/businessman-icon-v…on-vector-male-avatar-profile-image-182095609.jpg'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['4']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("4", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://www.shareicon.net/data/256x256/2016/05/26/771188_man_512x512.png'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['5']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("5", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://stanforduni.us/wp-content/uploads/2020/05/default-avatar.png'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['6']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("6", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://www.shareicon.net/data/256x256/2016/05/24/770121_man_512x512.png'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['7']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("7", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://homevest.com/wp-content/uploads/2019/05/female1-512.png'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['8']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("8", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
    Divider(
      height: 5,
    ),
    Container(
      height: 150,
      color: Colors.lightBlueAccent,
      child: Row(
        children: [
          Spacer(
            flex: 1,
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
                'https://www.pngitem.com/pimgs/m/0-6243_user-profile-avatar-scalable-vector-graphics-icon-woman.png'),
          ),
          Spacer(
            flex: 2,
          ),
          StoreConnector<AppState, User>(builder: (context, name) {
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                    150, 48),
              ),
              onPressed: () {
                if (name.inventory['9']==1){
                  return AlertDialog(
                      title: const Text('YOU HAVE THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Bought Item'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }else if(name.gold>500){
//                  FirebaseFirestore.instance.collection('users').doc(name.username).set({'gold' : (name.gold-500),
//                    'XP':name.XP,'level':name.level,'mail':name.mail,'pic_url':name.pic_url,'user_name':name.username,
//                    'inventory':name.inventory});
                  FirebaseFirestore.instance.collection('users').doc(name.username).update({'gold' : (name.gold-500)});
                  store.dispatch(setInventoryItemCount("9", 1));
                  print("Bought object");
                }else{
                  return AlertDialog(
                      title: const Text('YOU CANT BUY THIS'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: const <Widget>[
                            Text('Insufficient Gold Amount'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ]);
                }
              },
              icon: Icon(Icons.shopping_basket_outlined, size: 30),
              label: Text(
                "500 Coin",
                style: TextStyle(fontSize: 30),
              ),
            );},
              converter: (store) => store.state.user ?? User()
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    ),
  ];


  Widget pictures() => ListView(
        padding: EdgeInsets.all(8),
        children: listItems,
      );
}
