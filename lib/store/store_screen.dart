import 'package:agile_project/models/user.dart';
import 'package:agile_project/reducers/middlewares.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:agile_project/models/app_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class StoreItem {
  String name;
  String image;
  int price;

  StoreItem({this.name, this.image, this.price});
}

List<StoreItem> storeItems = [
  StoreItem(
      name: "50/50",
      price: 100,
      image:
          'https://tridacmortgages.com/wp-content/uploads/2011/09/5050_logo.png'),
  StoreItem(
      name: "pass",
      price: 100,
      image:
          'https://thumbs.dreamstime.com/b/pass-text-red-grungy-vintage-round-stamp-rubber-205333260.jpg'),
  StoreItem(
      name: "Avatar 1",
      price: 50,
      image:
          'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/131654569/original/fd45e2a3d3d1643130922e98b0ce921863b6127a/make-you-cartoon-avatar.jpeg'),
  StoreItem(
      name: "Avatar 2",
      price: 50,
      image:
          'https://t4.ftcdn.net/jpg/02/45/28/17/360_F_245281783_3zeOLu7mhjUmYbFlBwSNsfwQmQZzukWo.jpg'),
  StoreItem(
      name: "Avatar 3",
      price: 50,
      image:
          'https://www.kindpng.com/picc/m/24-248442_female-user-avatar-woman-profile-member-user-profile.png'),
  StoreItem(
      name: "Avatar 4",
      price: 50,
      image:
          'https://thumbs.dreamstime.com/b/businessman-icon-v…on-vector-male-avatar-profile-image-182095609.jpg'),
  StoreItem(
      name: "Avatar 5",
      price: 50,
      image:
          'https://www.shareicon.net/data/256x256/2016/05/26/771188_man_512x512.png'),
  StoreItem(
      name: "Avatar 6",
      price: 50,
      image:
          'https://stanforduni.us/wp-content/uploads/2020/05/default-avatar.png'),
  StoreItem(
      name: "Avatar 7",
      price: 50,
      image:
          'https://www.shareicon.net/data/256x256/2016/05/24/770121_man_512x512.png'),
  StoreItem(
      name: "Avatar 8",
      price: 50,
      image: 'https://homevest.com/wp-content/uploads/2019/05/female1-512.png'),
  StoreItem(
      name: "Avatar 9",
      price: 50,
      image:
          'https://www.pngitem.com/pimgs/m/0-6243_user-profile-avatar-scalable-vector-graphics-icon-woman.png'),
];

/*
StoreProvider.of<AppState>(context)
                        .dispatch(getUserDataFromFirebase()),
*/

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
        builder: (context, user) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'STORE',
              ),
              backgroundColor: Color(0xFF80D8FF),
              centerTitle: true,
              elevation: 0.0,
              leading: Container(),
              actions: [
                Text("Gold: ${user.gold}"),
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/landing');
                    },
                    icon: Icon(Icons.home)),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: storeItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 150,
                        color: Colors.lightBlueAccent,
                        child: Row(
                          children: [
                            Spacer(
                              flex: 1,
                            ),
                            CircleAvatar(
                              radius: 60,
                              backgroundImage:
                                  NetworkImage(storeItems[index].image),
                            ),
                            Spacer(
                              flex: 2,
                            ),
                            Column(
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  "${storeItems[index].price} Gold",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(150,
                                        48), // takes postional arguments as width and height
                                  ),
                                  onPressed: () async {
                                    String bought_item = storeItems[index].name;
                                    if (user.gold < storeItems[index].price) {
                                      print("${user.gold} Not enough gold!");
                                      _showDialog("Not enough gold!",
                                          "You have ${user.gold} gold.");
                                    } else {
                                      print("Bought!");
                                      _showDialog("Bought!",
                                          "${storeItems[index].name} added to your inventory.");
                                      //firebase - increase user inventory item count
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.username.toString())
                                          .update(
                                        {
                                          "inventory.$bought_item":
                                              FieldValue.increment(1),
                                        },
                                      );
                                      //firebase - decrease price from users gold field
                                      int deductedPrice =
                                          storeItems[index].price;
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(user.username)
                                          .update({
                                        "gold":
                                            FieldValue.increment(-deductedPrice)
                                      });
                                      StoreProvider.of<AppState>(context)
                                          .dispatch(getUserDataFromFirebase(
                                              user.mail));
                                    }
                                  },
                                  icon: Icon(Icons.shopping_basket_outlined,
                                      size: 20),
                                  label: Text(
                                    "BUY",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                            Spacer(
                              flex: 1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
        converter: (store) => store.state.user);
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new OutlinedButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
