import 'dart:math';

import 'package:agile_project/questions/questions_controller.dart';
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

class QuestionsScreen extends GetView<QuestionsController> {
  @override
  Widget build(BuildContext context) {
    @override
    final String category = ModalRoute.of(context).settings.arguments;
    final QuestionsController controller =
        Get.put(QuestionsController(category));

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
  List<Icon> scoreKeeper = [];
  List<int> scoreList = [];
  double difficultyMultiplier = 1;
  int gainedGold = 0;

  void checkAnswer(String userPickedAnswer) {
    String correctAnswer = widget.controller.getCorrectAnswer();

    setState(() {
      if (widget.controller.areQuestionsFinished()) {
        //showAlert();

        aps.store.dispatch(incUserStat("quiz_completed", 1));
        final int xpToAdd =
            (scoreList.reduce((a, b) => a + b) * 10 * difficultyMultiplier)
                    .round() +
                widget.controller.getTime();
        final int correctCount = scoreList.reduce((a, b) => a + b);

        print(widget.controller.getTime());
        widget.controller.reset();
        scoreKeeper = [];

        String goldImg =
            "https://thumbs.dreamstime.com/b/gold-trophy-cup-winner-concept-hand-drawn-vector-illustration-isolated-dark-white-background-189822133.jpg";
        String silverImg =
            "https://5.imimg.com/data5/WX/SJ/MY-3175717/silver-trophy-500x500.jpg";
        String bronzeImg =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS582ExGF6WVg-aLqv8BNkbL_j_3O_3qtckjQ&usqp=CAU";

        String bronzeText = "Congratulations!\n You answered " +
            correctCount.toString() +
            " questions correctly. You are rewarded with 10 gold.";

        String silverText = "Congratulations!\n You answered " +
            correctCount.toString() +
            " questions correctly. You are rewarded with 25 gold.";

        String goldText =
            "Congratulations!\n You answered all questions correctly. You are rewarded with 100 gold.";

        var currentText;
        var currentImg;

        if (correctCount > 4 && correctCount <= 7) {
          currentImg = bronzeImg;
          currentText = bronzeText;
          gainedGold += 10;
        }
        if (correctCount > 7) {
          currentImg = silverImg;
          currentText = silverText;
          gainedGold += 25;
        }
        if (correctCount == 10) {
          currentImg = goldImg;
          currentText = goldText;
          gainedGold += 100;
        }

        aps.store.dispatch(addXPGold(xpToAdd, gainedGold));
        Alert(
            context: context,
            image: Image.network(currentImg),
            content: Text(
              currentText,
              textAlign: TextAlign.center,
            ),
            buttons: [
              DialogButton(
                onPressed: () => Navigator.of(context, rootNavigator: true)
                    .popAndPushNamed("/leaderboard"),
                child: Text(
                  "Cool",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
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
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          scoreList.add(1);
          widget.controller.addTime();
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
          scoreList.add(0);
        }
        widget.controller.nextQuestion();
      }
    });

    /*
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: [
            DialogButton(
              child: Text(
                "Play again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
              width: 120,
            ),
            DialogButton(
              child: Text(
                "Leaderboard",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed("/leaderboard");
              },
              width: 120,
            )
          ],
        ).show();
*/
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
                      duration: 60,
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
                      onComplete: () {
                        print('Countdown Ended');
                        widget.controller.timeEnded.value = true;
                        widget.controller.reset();
                        scoreKeeper = [];
                        Navigator.of(context, rootNavigator: true)
                            .popAndPushNamed("/leaderboard");
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
                return Column(
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
                            children: returnExpandedWidgets(widget.controller),
                          );
                        }),
                      ),
                    ),
                    Row(
                      children: scoreKeeper,
                    )
                  ],
                );
              })
            ]);
    });
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
            //The user picked true.
            checkAnswer(text);
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
