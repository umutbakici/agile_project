import 'package:agile_project/models/app_state.dart';
import 'package:agile_project/reducers/actions.dart';
import 'package:agile_project/reducers/middlewares.dart';
import 'package:agile_project/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginScreen extends StatefulWidget {
  SignInState createState() => SignInState();
}

class SignInState extends State<LoginScreen> {
  AuthService _authService = AuthService();

  String _mail;
  String _password;
  var _isPasswordHidden = true;

  final _formKey = GlobalKey<FormState>();

  logIn(BuildContext context) {
    _authService
        .signIn(_mail, _password)
        .then((value) => {
              if (value == "Singed in")
                {Navigator.pushNamed(context, '/landing')}
              else
                print("Login failed")
            })
        .catchError((e) {});
  }

  String handleMail(value) {
    if (value == null || value.isEmpty) {
      return "You must enter your mail address!";
    }
    return null;
  }

  String handlePassword(value) {
    if (value == null) {
      return "You must enter your password!";
    }
    if (value.length < 6) {
      return "Password must be at least 6 characters long!";
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
                    'LOGIN',
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
                    onChanged: (entry) => _mail = entry,
                    validator: handleMail,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (entry) => _password = entry,
                    validator: handlePassword,
                    obscureText: _isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: TextButton(
                        child: Icon(Icons.remove_red_eye),
                        onPressed: (() {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        }),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          print(
                              'Forgotted Password!'); /* TODO: forgot password flow */
                        },
                        child: Text(
                          'Forgot Password?',
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
                          return () => store
                              .dispatch(getUserDataFromFirebase("tuvangezer"));
                        },
                        builder: (context, callback) => MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  try {
                                    logIn(context);
                                    callback();
                                  } catch (e) {}
                                }
                              },
                              color: Colors.blue,
                              child: Text(
                                'LOGIN',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '''Don't have an account? ''',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontSize: 16.0,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Text('Register Now'),
                      )
                    ],
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
