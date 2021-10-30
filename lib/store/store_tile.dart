import 'package:flutter/material.dart';

class StoreTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Spacer(flex: 1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('ITEMS:')],
              ),
              Spacer(flex: 5),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/');
                  },
                  child: Text('Click To Buy',
                      style: TextStyle(
                        color: Color(0xFF80D8FF),
                      ))),
              Spacer(flex: 1),
            ],
          )),
    );
  }
}