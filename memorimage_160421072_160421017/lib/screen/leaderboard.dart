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
  List<List<String>> topScores = [
    ['none', '0'],
    ['none', '0'],
    ['none', '0']
  ];
  @override
  void initState() {
    super.initState();
    loadTopScores();
  }

  void loadTopScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      topScores[0] = prefs.getStringList('top1') ?? ['none', '0'];
      topScores[1] = prefs.getStringList('top2') ?? ['none', '0'];
      topScores[2] = prefs.getStringList('top3') ?? ['none', '0'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: ListView(
          children: <Widget>[
            Text(
              "Leaderboard",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              textAlign: TextAlign.center,
            ),
            for (int i = 0; i < 3; i++)
              ListTile(
                title: Text(topScores[i][0]),
                subtitle: Text(topScores[i][1]),
              )
          ],
        ));
  }
}
