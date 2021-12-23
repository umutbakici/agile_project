import 'package:agile_project/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'models/app_state.dart';
import 'models/user.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

AuthService _authService = AuthService();

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
        builder: (context, user) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'ADMIN PAGE',
                //style:
              ),
              backgroundColor: Color(0xFF80D8FF),
              centerTitle: true,
              elevation: 0.0,
              leading: Container(),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/landing');
                    },
                    icon: Icon(Icons.home)),
              ],
            ),
            body: SafeArea(
              maintainBottomViewPadding: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          width: 8.0,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            //Navigator.pushNamed(context, '/');
                            //_authService.signOut();
                          },
                          child: Text(
                            'Add Question',
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF80D8FF)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        converter: (store) => store.state.user);
  }
}
