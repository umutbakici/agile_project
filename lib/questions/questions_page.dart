import 'package:agile_project/questions/questions_controller.dart';
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

  void checkAnswer(String userPickedAnswer) {
    String correctAnswer = widget.controller.getCorrectAnswer();

    setState(() {
      if (widget.controller.isFinished() == true) {
        aps.store.dispatch(addXP(scoreList.reduce((a, b) => a + b)));
        print(scoreList.reduce((a, b) => a + b));
        Navigator.of(context, rootNavigator: true).pushNamed("/leaderboard");
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

        widget.controller.reset();

        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
          scoreList.add(1);
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
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.controller.isLoading.value
          ? Center(
              child: AnimatedOpacity(
                opacity: widget.controller.isLoading.value ? 1 : 0,
                duration: Duration(milliseconds: 100),
                child: CircularProgressIndicator.adaptive(),
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
                    child: Obx(() {
                      return Container(
                        margin: EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: returnExpandedWidgets(widget.controller),
                        ),
                      );
                    })),
                Row(
                  children: scoreKeeper,
                )
              ],
            );
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
    List<Expanded> tempList = [];
    List allChoices = controller.getAllChoices();
    int i = 0;
    while (i < controller.numberOfChoices) {
      tempList.add(buildExpanded(allChoices[i]));
      i++;
    }
    return tempList;
  }
}
