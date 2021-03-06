import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:agile_project/reducers/middlewares.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:agile_project/models/app_state.dart' as aps;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'mp_questions_controller.dart';

class MPQuestionsPage extends GetView<MPQuestionsController> {
  @override
  Widget build(BuildContext context) {
    @override
    final String category = ModalRoute.of(context).settings.arguments;
    final MPQuestionsController controller =
        Get.put(MPQuestionsController(category));
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(controller: controller),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final controller;

  const QuizPage({this.controller});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<int> scoreList = [];
  double difficultyMultiplier = 1;
  int gainedGold = 0;
  String userPickedAnswer = "";
  bool hasAnswered = false;

  void checkAnswer() {
    String correctAnswer = widget.controller.getCorrectAnswer();
    if (widget.controller.areQuestionsFinished()) {
      Navigator.pop(context);
    } else {
      if (userPickedAnswer == correctAnswer) {
        gainedGold += 5;
        String difficulty = widget.controller.getDifficulty();
        aps.store.dispatch(incUserStat("questions_answered", 1));

        aps.store.dispatch(
            incUserStat("${widget.controller.getCategory()}_answered", 1));
        switch (difficulty) {
          case "medium":
            {
              difficultyMultiplier += 0.1;
              aps.store.dispatch(incUserStat("medium_questions_answered", 1));
            }
            break;
          case "hard":
            {
              difficultyMultiplier += 0.2;
              aps.store.dispatch(incUserStat("hard_questions_answered", 1));
            }
            break;
          case "easy":
            {
              aps.store.dispatch(incUserStat("easy_questions_answered", 1));
            }
            break;
        }
        scoreList.add(1);
        try {
          widget.controller.increaseMyScore();
        } catch (e) {}
      } else {
        scoreList.add(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /*if (widget.controller.timeEnded.value) {
        Future.delayed(Duration.zero, () => finish());
      }*/
      return widget.controller.isLoading.value
          ? Center(
              child: AnimatedOpacity(
                opacity: widget.controller.isLoading.value ? 1 : 0,
                duration: Duration(milliseconds: 100),
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : Stack(children: [
              Obx(() {
                return Row(children: [
                  Container(
                    child: CircularCountDownTimer(
                      duration: 10,
                      initialDuration: 0,
                      controller: widget.controller.countDownController.value,
                      width: 50,
                      height: 50,
                      ringColor: Colors.grey[300],
                      ringGradient: null,
                      fillColor: Colors.purpleAccent[100],
                      fillGradient: null,
                      backgroundColor: Colors.purple[500],
                      backgroundGradient: null,
                      strokeWidth: 20.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                          fontSize: 33.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.S,
                      isReverse: true,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        print('Countdown Started');
                      },
                      onComplete: () async {
                        print('Countdown Ended');
                        checkAnswer();
                        await Future.delayed(Duration(seconds: 1));
                        showDialog(
                          context: context,
                          builder: (context) {
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.of(context).pop(true);
                              widget.controller.reset();
                              setState(() {
                                hasAnswered = false;
                              });
                            });
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              elevation: 16,
                              child: Container(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    Center(child: Text('Leaderboard')),
                                    SizedBox(height: 20),
                                    _buildRow(
                                        aps.store.state.user.username,
                                        (scoreList
                                            .where((e) => e == 1)
                                            .length)),
                                    _buildRow(
                                      widget.controller.getOtherUsername(),
                                      widget.controller.getOtherUserScore(),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    margin: EdgeInsets.only(left: 30, top: 30),
                  ),
                  Container(
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "https://tridacmortgages.com/wp-content/uploads/2011/09/5050_logo.png"),
                      ),
                      onTap: () {
                        widget.controller.useFiftyFiftyJoker();
                      },
                    ),
                    margin: EdgeInsets.only(left: 30, top: 30),
                  ),
                  Container(
                    child: GestureDetector(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/b/pass-text-red-grungy-vintage-round-stamp-rubber-205333260.jpg'),
                      ),
                      onTap: () {
                        widget.controller.usePassJoker();
                      },
                    ),
                    margin: EdgeInsets.only(left: 20, top: 30),
                  ),
                ]);
              }),
              Obx(() {
                return hasAnswered
                    ? Center(
                        child: Text(
                          "waiting for timer to finish...",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  widget.controller.getQuestionText(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 40),
                              child: Obx(() {
                                return Column(
                                  children:
                                      returnExpandedWidgets(widget.controller),
                                );
                              }),
                            ),
                          ),
                        ],
                      );
              })
            ]);
    });
  }

  Widget _buildRow(String name, int score) {
    String imageAsset =
        "https://p.kindpng.com/picc/s/24-248253_user-profile-default-image-png-clipart-png-download.png";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          Container(height: 2, color: Colors.redAccent),
          SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleAvatar(backgroundImage: NetworkImage(imageAsset)),
              SizedBox(width: 12),
              Text(name),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.yellow[900],
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text('$score'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Expanded buildExpanded(text) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: FlatButton(
          textColor: Colors.white,
          color: Colors.green,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            userPickedAnswer = text;
            setState(() {
              hasAnswered = true;
            });
          },
        ),
      ),
    );
  }

  List<Expanded> returnExpandedWidgets(controller) {
    int numberOfChoices = controller.numberOfChoices;
    List<Expanded> tempList = [];
    List allChoices = controller.getAllChoices();
    if (controller.isFiftyFiftyActive.value) {
      numberOfChoices = 2;
      //List<String> toBeRemoved = [];
      String correctAnswer = controller.getCorrectAnswer();
      try {
        while (allChoices.length > 2) {
          int randomInt = Random().nextInt(allChoices.length);
          if (allChoices[randomInt] != correctAnswer) {
            allChoices.removeAt(randomInt);
          }
        }
      } catch (Exception) {}
    }
    int i = 0;
    while (i < numberOfChoices) {
      tempList.add(buildExpanded(allChoices[i]));
      i++;
    }
    return tempList;
  }
}
