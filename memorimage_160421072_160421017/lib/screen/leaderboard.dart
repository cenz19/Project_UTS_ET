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
  List<String> gelars = [
    "Sfortunato Indovinatore",
    "Neofita dell'Indovinello",
    "Principiante dell'Indovinello",
    "Abile Indovinatore",
    "Esperto dell'Indovinello",
    "Maestro dell'Indovinello"
  ];

  String gelar() {
    String gelar = "";
    if (top_point == 0) {
      gelar = gelars[0];
    } else if (top_point == 100) {
      gelar = gelars[1];
    } else if (top_point == 200) {
      gelar = gelars[2];
    } else if (top_point == 300) {
      gelar = gelars[3];
    } else if (top_point == 400) {
      gelar = gelars[4];
    } else {
      gelar = gelars[5];
    }
    return gelar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Leaderboard'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Text("Selamat anda mendapat gelar " + gelar()),
        ));
  }
}
