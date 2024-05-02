import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:memorimage_160421072_160421017/class/questionBank.dart';
import 'package:memorimage_160421072_160421017/screen/hasil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memorimage_160421072_160421017/main.dart';

void getScore(int point) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt("score", point);
}

void top3(int point) async {
  final prefs = await SharedPreferences.getInstance();
  List<List<String>> topScores = [
    prefs.getStringList('top1') ?? ['none', '0'],
    prefs.getStringList('top2') ?? ['none', '0'],
    prefs.getStringList('top3') ?? ['none', '0']
  ];

  for (int i = 0; i < topScores.length; i++) {
    int currentScore = int.parse(topScores[i][1]);
    if (point > currentScore) {
      topScores.insert(i, [active_user, point.toString()]);
      topScores.removeLast(); // Remove the lowest score
      break;
    }
  }
  await prefs.setStringList('top1', topScores[0]);
  await prefs.setStringList('top2', topScores[1]);
  await prefs.setStringList('top3', topScores[2]);
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _initialValue = 30;
  int _hitung = 30;
  int _hitungAnimasi = 15;
  String _imgHint = "";
  late Timer _timer;
  late Timer _timerAnimation;
  List<QuestionObj> _questions = [];
  List<String> _hints = [];
  int _question_no = 0;
  int _point = 0;
  double _imgWidth = 200;
  double _imgHeight = 200;
  bool visibleHint = true;
  bool visibleMain = false;

  @override
  void initState() {
    super.initState();
    _questions.add(QuestionObj(
      "images/a.png",
      "images/b.png",
      "images/c.png",
      "images/d.png",
      "images/a.png",
    ));
    _questions.add(QuestionObj(
      "images/a.png",
      "images/b.png",
      "images/c.png",
      "images/d.png",
      "images/b.png",
    ));
    _questions.add(QuestionObj(
      "images/a.png",
      "images/b.png",
      "images/c.png",
      "images/d.png",
      "images/c.png",
    ));
    _questions.add(QuestionObj(
      "images/a.png",
      "images/b.png",
      "images/c.png",
      "images/d.png",
      "images/d.png",
    ));
    _questions.add(QuestionObj(
      "images/a.png",
      "images/b.png",
      "images/c.png",
      "images/d.png",
      "images/a.png",
    ));
    Set<int> uniqueNumbers = Set<int>();
    Random random = Random();

    while (uniqueNumbers.length < 5) {
      uniqueNumbers.add(random.nextInt(5));
    }
    List<int> randomNumbers = uniqueNumbers.toList();
    for (int number in randomNumbers) {
      _hints.add(_questions[number].answer);
      print(number);
    }
    _imgHint = _hints[0];
    StartAnimation();
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        _point += 100;
      }
      nextQuestion();
    });
  }

  void nextQuestion() {
    _question_no++;
    _hitung = _initialValue;
    if (_question_no > _questions.length - 1) finishQuiz();
  }

  void StartAnimation() {
    _timerAnimation = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_hitungAnimasi > 1) {
          _hitungAnimasi--;
          if (_hitungAnimasi > 12) {
            _imgHint = _hints[0];
          } else if (_hitungAnimasi > 9) {
            _imgHint = _hints[1];
          } else if (_hitungAnimasi > 6) {
            _imgHint = _hints[2];
          } else if (_hitungAnimasi > 3) {
            _imgHint = _hints[3];
          } else if (_hitungAnimasi > 0) {
            _imgHint = _hints[4];
          }
        } else {
          visibleHint = false;
          visibleMain = true;
          _timerAnimation.cancel();
          StartTimer();
        }
      });
    });
  }

  void StartTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (_hitung > 0) {
          _hitung--;
        } else {
          nextQuestion();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _hitung = _initialValue;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            Visibility(
              visible: visibleHint,
              child: Center(
                child: Image.asset(
                  _imgHint,
                  width: 200, // Set width if needed
                  height: 200, // Set height if needed
                ),
              ),
            ),
            Visibility(
              visible: visibleMain,
              child: Center(
                child: Column(
                  children: <Widget>[
                    CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 20.0,
                      percent: (_hitung / _initialValue),
                      center: Text(formatTime(_hitung)),
                      progressColor: Colors.green,
                    ),
                    Divider(
                      height: 10,
                    ),
                    Text("which image"),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              checkAnswer(_questions[_question_no].img_a);
                            },
                            icon: Image.asset(
                              "images/earth.png",
                              width: _imgWidth,
                              height: _imgHeight,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              checkAnswer(_questions[_question_no].img_b);
                            },
                            icon: Image.asset(
                              "images/earth.png",
                              width: _imgWidth,
                              height: _imgHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              checkAnswer(_questions[_question_no].img_c);
                            },
                            icon: Image.asset(
                              "images/earth.png",
                              width: _imgWidth,
                              height: _imgHeight,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              checkAnswer(_questions[_question_no].img_d);
                            },
                            icon: Image.asset(
                              "images/earth.png",
                              width: _imgWidth,
                              height: _imgHeight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  finishQuiz() {
    _timer.cancel();
    _question_no = 0;
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Quiz'),
              content: Text('Your point = ' + _point.toString()),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    Navigator.popAndPushNamed(context, 'hasil');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    top3(_point);
    getScore(_point);
  }
}

String formatTime(int hitung) {
  var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (hitung % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}
