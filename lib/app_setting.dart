import 'package:agile_project/service/auth.dart';
import 'package:flutter/material.dart';

class AppSetting extends StatefulWidget {
  @override
  _AppSettingState createState() => _AppSettingState();
}

bool isMuted = false;
AuthService _authService = AuthService();

class _AppSettingState extends State<AppSetting> {
  @override
  Widget build(BuildContext context) {
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
