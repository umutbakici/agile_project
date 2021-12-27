import 'dart:async';
import 'dart:math';
import 'package:agile_project/models/room.dart';
import 'package:agile_project/models/user.dart' as au;
import 'package:agile_project/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:agile_project/models/app_state.dart' as aps;

class MPQuestionsController extends GetxController {
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

  MPQuestionsController(this.category);
  final timeEnded = false.obs;

  final otherUserName = "".obs;
  final otherUserScore = 0.obs;

  onInit() async {
    await fetchQuestionsData();
    await fetchUsersData();
    await fetchOtherUserData();
    await fetchOtherUserScore();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> fetchOtherUserScore() async {
    Stream documentStream = FirebaseFirestore.instance
        .collection('rooms')
        .doc(aps.store.state.room.roomID)
        .snapshots();
    documentStream.listen((event) {
      if (aps.store.state.room.players[0] == aps.store.state.user.username) {
        //I'm host
        otherUserScore.value = event.data()["guestScore"];
      } else {
        otherUserScore.value = event.data()["hostScore"];
      }
    });
  }

  Future<void> fetchOtherUserData() async {
    QuerySnapshot collectionSnapshot;
    List tempList = [];
    try {
      collectionSnapshot = await firestore
          .collection("rooms")
          .where("roomID", isEqualTo: aps.store.state.room.roomID)
          .get();
      tempList = collectionSnapshot.docs;
      if (tempList[0]["players"][0] == aps.store.state.user.username) {
        otherUserName.value = tempList[0]["players"][1];
      } else {
        otherUserName.value = tempList[0]["players"][0];
      }
    } catch (e) {
      print(e);
    }
  }

  increaseMyScore() async {
    if (aps.store.state.room.players[0] == aps.store.state.user.username) {
      //I'm host
      Room r = aps.store.state.room;
      r.hostScore = r.hostScore + 1;
      await FirebaseFirestore.instance
          .collection("rooms")
          .doc(aps.store.state.room.roomID)
          .set(r.toMap());
    } else {
      Room r = aps.store.state.room;
      r.guestScore = r.guestScore + 1;
      await FirebaseFirestore.instance
          .collection("rooms")
          .doc(aps.store.state.room.roomID)
          .set(r.toMap());
    }
  }

  getOtherUsername() {
    return otherUserName.value;
  }

  getOtherUserScore() {
    return otherUserScore.value;
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
    countDownController.value.restart(duration: 10);
    nextQuestion();
  }

  int getTime() {
    return int.parse(countDownController.value.getTime());
  }
}
