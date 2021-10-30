import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HOME',
          //style:
        ),
        backgroundColor: Color(0xFF80D8FF),
        centerTitle: true,
        elevation: 0.0,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                //TO DO SETTINGS
                //Navigator.pushNamed(context, '/settings');
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: SafeArea(
        maintainBottomViewPadding: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: RichText(
                  text: TextSpan(
                    text: "Welcome to Question App",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
                padding: const EdgeInsets.all(40.0),
                child: SizedBox(
                  child: Image.network(
                      'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/4003c83e-52f7-40e7-9361-7bc0720753c0/dbw6u5z-49e1dcf8-3cb8-4dc6-8f68-2a57d2a5e722.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzQwMDNjODNlLTUyZjctNDBlNy05MzYxLTdiYzA3MjA3NTNjMFwvZGJ3NnU1ei00OWUxZGNmOC0zY2I4LTRkYzYtOGY2OC0yYTU3ZDJhNWU3MjIucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.nKJjcRhK5PDB4zBcIjfdZ3yTNmBS9HHCizVHAtAAJo0'),
                  height: 256,
                  width: 256,
                )),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        //TODO: SIGNUP
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Signup',
                          //style:
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF80D8FF),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Login',
                          //style:
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFF80D8FF)),
                    ),
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
