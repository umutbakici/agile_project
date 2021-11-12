import 'dart:math';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class QuestionsController extends GetxController {
  final int numberOfChoices = 4;
  final int totalQuestionNumber = 10;
  int _questionNumber = 0;
  final _questionsList = [].obs;
  final isLoading = true.obs;
  final firestore = FirebaseFirestore.instance;

  onInit() async {
    await fetchData();
    isLoading.value = false;
    super.onInit();
  }

  Future<void> fetchData() async {
    QuerySnapshot collectionSnapshot;
    List tempList = [];
    try {
      collectionSnapshot = await firestore.collection("questions").get();
      tempList = collectionSnapshot.docs;
      trimList(tempList);
    } catch (e) {
      print(e);
    }
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
    }
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

  bool isFinished() {
    if (_questionNumber >= _questionsList.value.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
    fetchData();
  }
}