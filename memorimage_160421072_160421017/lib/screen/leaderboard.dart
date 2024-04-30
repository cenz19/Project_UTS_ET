import 'package:flutter/material.dart';
import 'package:memorimage_160421072_160421017/main.dart';
import 'package:memorimage_160421072_160421017/screen/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderBoardForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Center(
        child: Text("This is Leaderboard"),
      ),
    );
  }
}

class LeaderBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeaderBoardState();
  }
}

class _LeaderBoardState extends State<LeaderBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Text("This is Leaderboard " + top_point.toString()),
        ));
  }
}
