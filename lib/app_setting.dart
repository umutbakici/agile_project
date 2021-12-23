import 'package:agile_project/service/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'models/app_state.dart';
import 'models/user.dart';

class AppSetting extends StatefulWidget {
  @override
  _AppSettingState createState() => _AppSettingState();
}

bool isMuted = false;
AuthService _authService = AuthService();

class _AppSettingState extends State<AppSetting> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
        builder: (context, user) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'APP SETTINGS',
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
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              if (isMuted)
                                isMuted = false;
                              else
                                isMuted = true;
                            });
                          },
                          child: isMuted
                              ? Text(
                                  'Unmute',
                                  //style:
                                )
                              : Text(
                                  'Mute',
                                  //style:
                                ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xFF80D8FF),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                            _authService.signOut();
                          },
                          child: Text(
                            'Logout',
                          ),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color(0xFF80D8FF)),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            if (user.isAdmin)
                              Navigator.pushNamed(context, '/admin_page');
                            else
                              _showDialog("Error", "No Access");
                          },
                          child: Text(
                            'Admin Page',
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

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            new OutlinedButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
