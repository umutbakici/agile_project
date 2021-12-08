import 'package:flutter/material.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({Key key}) : super(key: key);

  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class Achievement {
  String name;
  String description;
  String image;
  bool locked;

  Achievement({this.name, this.description, this.image});
}

List<Achievement> Achievements = [
  Achievement(
      name: "In a Hurry!",
      description: "Complete a quiz less than 10 seconds",
      image:
          "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png"),
  Achievement(
      name: "Jack of all trades",
      description: "In random choice, answer all questions correct",
      image:
          "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png"),
  Achievement(
      name: "Unlucky Day",
      description: "In random choice, answer all questions incorrect",
      image:
          "https://www.pngkit.com/png/detail/30-309466_gold-cup-trophy-png-image-gold-cup-png.png"),
  Achievement(
      name: "Online!",
      description: "Play multiplayer mode first time",
      image: "https://icon-library.com/images/lock-icon/lock-icon-10.jpg"),
  Achievement(
      name: "I will win this round",
      description: "Buy jokers from the shop first time",
      image: "https://icon-library.com/images/lock-icon/lock-icon-10.jpg"),
];

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'ACHIEVEMENTS',
            //style:
          ),
          backgroundColor: Color(0xFF80D8FF),
          centerTitle: true,
          elevation: 0.0,
          leading: Container(),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                icon: Icon(Icons.home)),
          ],
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              itemCount: Achievements.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
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
                            children: [
                              Image.network(
                                Achievements[index].image,
                                width: 64,
                                height: 64,
                              )
                            ],
                          ),
                          Spacer(flex: 5),
                          Column(
                            children: [
                              Center(
                                  child: Text(Achievements[index].name,
                                      style: TextStyle(
                                          color: Color(0xFF00695C),
                                          fontWeight: FontWeight.bold))),
                              SizedBox(height: 16),
                              Center(
                                  child: SizedBox(
                                      width: 256,
                                      height: 48,
                                      child: Expanded(
                                        child: Text(
                                          Achievements[index].description,
                                          style: TextStyle(
                                            color: Color(0xFF263238),
                                          ),
                                        ),
                                      )))
                            ],
                          ),
                          Spacer(flex: 1),
                        ],
                      )),
                );
              },
            ),
          )
        ]));
  }
}
