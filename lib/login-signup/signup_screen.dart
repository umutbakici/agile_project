import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/middlewares.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../service/auth.dart';

class SignupScreen extends StatefulWidget {
  SignupState createState() => SignupState();
}

class SignupState extends State<SignupScreen> {
  String mail;
  String userName;
  String password;
  String confirmPassword;

  var isPasswordHidden = true;
  var isConfirmPasswordHidden = true;

  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  List userNames;

  SignupState(
      {String mail, String userName, String password, String confirmPassword}) {
    _authService.getUserNames().then((value) => userNames = value);
  }

  signUp(BuildContext context) {
    _authService.signUp(mail, password, userName);
  }

  String handleUserName(String value) {
    if (value == null) {
      return "You need to enter a user name!";
    }
    if (value.length < 6) {
      return "Your user name needs to be at least 6 characters long!";
    }

    bool isNameExists = false;
    userNames.forEach((userName) {
      if (value == userName) {
        isNameExists = true;
      }
    });
    if (isNameExists) {
      return "Username already exists";
    }

    return null;
  }

  String handlePassword(String value) {
    if (value == null) {
      return "You need to enter your password!";
    }
    if (value.length < 6) {
      return "Password needs to be 6 characters long!";
    }
    return null;
  }

  String handleConfirmPassword(String value) {
    if (password == null) {
      return "You need to enter your password!";
    }
    if (value == null) {
      return "You need to confirm your password!";
    }
    if (password != value) {
      return "Passwords must match!";
    }
    return null;
  }

  String handleMail(String value) {
    if (value == null) {
      return "You have to enter an email!";
    }
    if (value.isEmpty) {
      return "Your email con not be empty!";
    }
    if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
      return "Email is not correct!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'SIGNUP',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 60.0,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (text) => mail = text,
                    validator: handleMail,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (text) => userName = text,
                    validator: handleUserName,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.supervised_user_circle_rounded),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (text) => password = text,
                    validator: handlePassword,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: TextButton(
                        child: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (text) => confirmPassword = text,
                      validator: handleConfirmPassword,
                      obscureText: isConfirmPasswordHidden,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: TextButton(
                            child: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordHidden =
                                    !isConfirmPasswordHidden;
                              });
                            }),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.blue,
                          width: 2,
                        )),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: StoreConnector<AppState, VoidCallback>(
                        converter: (store) {
                          return () =>
                              store.dispatch(getUserDataFromFirebase(mail));
                        },
                        builder: (context, callback) => MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    signUp(context);
                                    callback();
                                    Navigator.pushNamed(context, "/landing");
                                  } catch (e) {}
                                }
                              },
                              color: Colors.blue,
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(
                    color: Colors.black,
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
