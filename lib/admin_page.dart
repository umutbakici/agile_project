import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'models/app_state.dart';
import 'models/user.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String category;
  String correct_answer;
  String difficulty = "easy";
  String incorrect_answer1;
  String incorrect_answer2;
  String incorrect_answer3;
  Map<String, dynamic> incorrect_answers = {}; //incorrect_answers {0, 1, 2}
  String question;
  String rand;

  final _formKey = GlobalKey<FormState>();

  String handleQuestion(String value) {
    if (value == "") {
      return "Enter a question!";
    }
    return null;
  }

  String handleCorrectAnswer(String value) {
    if (value == "") {
      return "Enter a correct answer!";
    }
    return null;
  }

  String handleIncorrectAnswer(String value) {
    if (value == "") {
      return "Enter an incorrect answer!";
    }
    return null;
  }

  String handleCategory(String value) {
    if (value == "") {
      return "Enter a category!";
    }
    return null;
  }

  String handleRand(String value) {
    if (value == "") {
      return "Enter the rarity of question (btwn 0 - 1)";
    }
    if (value != "") {
      if (double.parse(value) >= 1.0 || double.parse(value) <= 0.0) {
        return "Enter the rarity of question (btwn 0 - 1)";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
        builder: (context, user) {
          return Scaffold(
            appBar: AppBar(
              title: Text("ADD QUESTION"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (text) => question = text,
                          validator: handleQuestion,
                          decoration: InputDecoration(
                            labelText: 'Question',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.quiz_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (text) => correct_answer = text,
                          validator: handleCorrectAnswer,
                          decoration: InputDecoration(
                            labelText: 'Correct Answer',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.thumb_up_alt_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (text) => incorrect_answer1 = text,
                          validator: handleIncorrectAnswer,
                          decoration: InputDecoration(
                            labelText: 'Incorrect Answer 1',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.thumb_down_alt_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (text) => incorrect_answer2 = text,
                          validator: handleIncorrectAnswer,
                          decoration: InputDecoration(
                            labelText: 'Incorrect Answer 2',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.thumb_down_alt_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (text) => incorrect_answer3 = text,
                          validator: handleIncorrectAnswer,
                          decoration: InputDecoration(
                            labelText: 'Incorrect Answer 3',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.thumb_down_alt_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          onChanged: (text) => category = text,
                          validator: handleCategory,
                          decoration: InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) => rand = text,
                          validator: handleRand,
                          decoration: InputDecoration(
                            labelText: 'Randomity',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.change_circle_outlined),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Question Difficulty: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue),
                            ),
                            DropdownButton<String>(
                              value: difficulty,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              style: const TextStyle(color: Colors.blue),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  difficulty = newValue;
                                });
                              },
                              items: <String>[
                                'easy',
                                'medium',
                                'hard'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    incorrect_answers = {
                                      "0": incorrect_answer1,
                                      "1": incorrect_answer2,
                                      "2": incorrect_answer3
                                    };

                                    print(
                                        "question: $question correct_answer: $correct_answer incorrect_answers: $incorrect_answers category: $category rand: $rand difficulty: $difficulty");

                                    print("VALIDATEDD");

                                    Navigator.pushNamed(
                                        context, "/app_setting");
                                  } catch (e) {}
                                }
                              },
                              color: Colors.blue,
                              child: Text(
                                'Add New Question',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        converter: (store) => store.state.user);
  }
}
