import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/profilepage/profilesetting.dart';
import 'package:agile_project/store/store_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Profile Page',
      routes: {
        '/store': (context) => StoreScreen(),
        '/profile_setting': (context) => ProfileSetting()
      },
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: new ProfilePage(title: ''),
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280; //cover image height
  final double profileHeight = 144;
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(children: [
          buildTop(),
        ]),
      ),
    ));
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final iconsLength = coverHeight + profileHeight - 60;
    return Container(
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              CoverImage(),
              Positioned(
                top: top, //distance between pp and top
                child: ProfileImage(),
              ),
            ],
          ),
          SizedBox(height: 70),
          Positioned(
            top: iconsLength,
            child: iconsBar(),
          ),
          SizedBox(height: 20),
          Positioned(
            top: iconsLength + 120,
            child: secondBar(),
          )
        ],
      ),
    );
  }

  Widget secondBar() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              MaterialButton(
                onPressed: () {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    StoreConnector<AppState, User>(
                        builder: (context, name) {
                          return Text(name.gold.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.amber));
                        },
                        converter: (store) => store.state.user ?? User()),
                    Text(
                      'GOLDS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.amber),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    StoreConnector<AppState, User>(
                        builder: (context, name) {
                          return Text(name.inventory['5050'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.amber));
                        },
                        converter: (store) => store.state.user ?? User()),
                    Text(
                      '5050',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.amber),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () {},
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    StoreConnector<AppState, User>(
                        builder: (context, name) {
                          return Text(name.inventory['pass'].toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.amber));
                        },
                        converter: (store) => store.state.user ?? User()),
                    Text(
                      'PASS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.orangeAccent),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(width: 45),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: profileHeight / 3,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/originals/3d/4f/8a/3d4f8a745269e02127b32dabf127361d.jpg'),
              ),
              const SizedBox(height: 25),
              CircleAvatar(
                radius: profileHeight / 3,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: NetworkImage(
                    'https://tridacmortgages.com/wp-content/uploads/2011/09/5050_logo.png'),
              ),
              const SizedBox(height: 25),
              CircleAvatar(
                radius: profileHeight / 3,
                backgroundColor: Colors.grey.shade800,
                backgroundImage: NetworkImage(
                    'https://thumbs.dreamstime.com/b/pass-text-red-grungy-vintage-round-stamp-rubber-205333260.jpg'),
              ),
            ],
          )
        ],
      );

  Widget iconsBar() => Column(
        children: [
          const SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
              stream: users,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return Column(
                  children: <Widget>[
                    StoreConnector<AppState, User>(
                        builder: (context, name) {
                          return Text(name.username,
                              style: TextStyle(fontSize: 28));
                        },
                        converter: (store) => store.state.user ?? User()),
                  ],
                );
              }),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/profile_setting');
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.account_circle_outlined,
                      color: Colors.brown,
                      size: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/store');
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.add_business_outlined,
                      color: Colors.brown,
                      size: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/leaderboard');
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.analytics_outlined,
                      color: Colors.brown,
                      size: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  Widget CoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://www.kindpng.com/picc/m/25-259078_aesthetic-background-for-youtube-80s-retro-facebook-cover.png',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget ProfileImage() => Column(
        children: [
          StoreConnector<AppState, User>(
              builder: (context, name) {
                return CircleAvatar(
                  radius: profileHeight / 2,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: NetworkImage(name.pic_url.toString()),
                );
              },
              converter: (store) => store.state.user ?? User()),
        ],
      );
}
