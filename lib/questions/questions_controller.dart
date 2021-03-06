import 'dart:async';
import 'dart:math';
import 'package:agile_project/models/user.dart' as au;
import 'package:agile_project/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class QuestionsController extends GetxController {
  final int numberOfChoices = 4;
  final int totalQuestionNumber = 10;
  int _questionNumber = 0;
  final _questionsList = [].obs;
  final isLoading = true.obs;
  final firestore = FirebaseFirestore.instance;
  String category = '';
  final _user = <au.User>[].obs;
  final isFiftyFiftyActive = false.obs;

  final countDownController = CountDownController().obs;

  QuestionsController(this.category);
  final timeEnded = false.obs;

  onInit() async {
    await fetchQuestionsData();
    await fetchUsersData();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> fetchQuestionsData() async {
    QuerySnapshot collectionSnapshot;
    List tempList = [];
    try {
      if (category == null) {
        collectionSnapshot = await firestore.collection("questions").get();
      } else {
        collectionSnapshot = await firestore
            .collection("questions")
            .where("category", isEqualTo: category)
            .get();
      }
      tempList = collectionSnapshot.docs;
      trimList(tempList);
    } catch (e) {
      print(e);
    }
  }

  fetchUsersData() async {
    try {
      _user.value[0] = await AuthService()
          .getUserWithEmail(FirebaseAuth.instance.currentUser.email);
    } catch (e) {
      print(e);
    }
  }

  useFiftyFiftyJoker() {
    isFiftyFiftyActive.value = true;
    //(removeAt)_user.value[0].jokers
  }

  usePassJoker() {
    nextQuestion();
    //(removeAt)_user.value[0].jokers
  }

  List trimList(oldList) {
    List newList = [];
    for (var i in chooseRandomElements(oldList)) {
      newList.add(oldList[i]);
    }
    _questionsList.value = newList;
  }

  List chooseRandomElements(list) {
    Set<int> setOfInts = Set();
    while (setOfInts.length < totalQuestionNumber) {
      setOfInts.add(Random().nextInt(list.length) + 1);
    }
    return setOfInts.toList();
  }

  void nextQuestion() {
    if (_questionNumber < totalQuestionNumber - 1) {
      _questionNumber++;
      isFiftyFiftyActive.value = false;
    }
  }

  String getDifficulty() {
    return _questionsList.value[_questionNumber]["difficulty"];
  }

  String getCategory() {
    return _questionsList.value[_questionNumber]["category"];
  }

  String getQuestionText() {
    return _questionsList.value[_questionNumber]["question"];
  }

  String getCorrectAnswer() {
    return _questionsList.value[_questionNumber]["correct_answer"];
  }

  List<String> getAllChoices() {
    List<String> tempList = [];
    tempList.add(_questionsList.value[_questionNumber]["correct_answer"]);
    tempList.add(_questionsList.value[_questionNumber]["incorrect_answers"][0]);
    tempList.add(_questionsList.value[_questionNumber]["incorrect_answers"][1]);
    tempList.add(_questionsList.value[_questionNumber]["incorrect_answers"][2]);
    //shuffle list
    tempList.shuffle();
    return tempList;
  }

  bool areQuestionsFinished() {
    if (_questionNumber >= _questionsList.value.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    Get.deleteAll(); //Deletes all Instances Data
    _questionNumber = 0;
    countDownController.value.restart();
    timeEnded.value = false;
    //fetchData();
  }

  void addTime() {
    countDownController.value
        .restart(duration: int.parse(countDownController.value.getTime()) + 5);
  }

  int getTime() {
    return int.parse(countDownController.value.getTime());
  }
}
