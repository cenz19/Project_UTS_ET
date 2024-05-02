import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:memorimage_160421072_160421017/class/questionBank.dart';
import 'package:memorimage_160421072_160421017/screen/hasil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

void getHighscore(int point) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt("score", point);
}

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _initialValue = 30;
  int _hitung = 30;
  int _hitungAnimasi = 0;
  String _imgHint = "";
  late Timer _timer;
  late Timer _timerAnimation;
  List<QuestionObj> _questions = [];
  List<String> _hints = [];
  int _question_no = 0;
  int _point = 0;
  double _imgWidth = 180;
  double _imgHeight = 180;
  bool visibleHint = true;
  bool visibleMain = false;

  @override
  void initState() {
    super.initState();
    _questions.add(QuestionObj(
      "images/c-1-1.png",
      "images/c-1-2.png",
      "images/c-1-3.png",
      "images/c-1-4.png",
      "images/c-1-1.png",
    ));
    _questions.add(QuestionObj(
      "images/c-2-1.png",
      "images/c-2-2.png",
      "images/c-2-3.png",
      "images/c-2-4.png",
      "images/c-2-2.png",
    ));
    _questions.add(QuestionObj(
      "images/c-3-1.png",
      "images/c-3-2.png",
      "images/c-3-3.png",
      "images/c-3-4.png",
      "images/c-3-3.png",
    ));
    _questions.add(QuestionObj(
      "images/c-4-1.png",
      "images/c-4-2.png",
      "images/c-4-3.png",
      "images/c-4-4.png",
      "images/c-4-4.png",
    ));
    _questions.add(QuestionObj(
      "images/c-5-1.png",
      "images/c-5-2.png",
      "images/c-5-3.png",
      "images/c-5-4.png",
      "images/c-5-1.png",
    ));
    _questions.add(QuestionObj(
      "images/c-6-1.png",
      "images/c-6-2.png",
      "images/c-6-3.png",
      "images/c-6-4.png",
      "images/c-6-2.png",
    ));
    _questions.add(QuestionObj(
      "images/c-7-1.png",
      "images/c-7-2.png",
      "images/c-7-3.png",
      "images/c-7-4.png",
      "images/c-7-3.png",
    ));
    _questions.add(QuestionObj(
      "images/c-8-1.png",
      "images/c-8-2.png",
      "images/c-8-3.png",
      "images/c-8-4.png",
      "images/c-8-4.png",
    ));
    _questions.add(QuestionObj(
      "images/c-9-1.png",
      "images/c-9-2.png",
      "images/c-9-3.png",
      "images/c-9-4.png",
      "images/c-9-1.png",
    ));
    _questions.add(QuestionObj(
      "images/c-10-1.png",
      "images/c-10-2.png",
      "images/c-10-3.png",
      "images/c-10-4.png",
      "images/c-10-2.png",
    ));
    _questions.add(QuestionObj(
      "images/c-11-1.png",
      "images/c-11-2.png",
      "images/c-11-3.png",
      "images/c-11-4.png",
      "images/c-11-3.png",
    ));
    _questions.add(QuestionObj(
      "images/c-12-1.png",
      "images/c-12-2.png",
      "images/c-12-3.png",
      "images/c-12-4.png",
      "images/c-12-4.png",
    ));
    _questions.add(QuestionObj(
      "images/c-13-1.png",
      "images/c-13-2.png",
      "images/c-13-3.png",
      "images/c-13-4.png",
      "images/c-13-1.png",
    ));
    _questions.add(QuestionObj(
      "images/c-14-1.png",
      "images/c-14-2.png",
      "images/c-14-3.png",
      "images/c-14-4.png",
      "images/c-14-2.png",
    ));
    _questions.add(QuestionObj(
      "images/c-15-1.png",
      "images/c-15-2.png",
      "images/c-15-3.png",
      "images/c-15-4.png",
      "images/c-15-3.png",
    ));
    _questions.add(QuestionObj(
      "images/c-16-1.png",
      "images/c-16-2.png",
      "images/c-16-3.png",
      "images/c-16-4.png",
      "images/c-16-4.png",
    ));
    _questions.add(QuestionObj(
      "images/c-17-1.png",
      "images/c-17-2.png",
      "images/c-17-3.png",
      "images/c-17-4.png",
      "images/c-17-1.png",
    ));
    _questions.add(QuestionObj(
      "images/c-18-1.png",
      "images/c-18-2.png",
      "images/c-18-3.png",
      "images/c-18-4.png",
      "images/c-18-2.png",
    ));
    _questions.add(QuestionObj(
      "images/c-19-1.png",
      "images/c-19-2.png",
      "images/c-19-3.png",
      "images/c-19-4.png",
      "images/c-19-3.png",
    ));
    _questions.add(QuestionObj(
      "images/c-20-1.png",
      "images/c-20-2.png",
      "images/c-20-3.png",
      "images/c-20-4.png",
      "images/c-20-4.png",
    ));
    _hitungAnimasi = 3 * _questions.length;
    Set<int> uniqueNumbers = Set<int>();
    Random random = Random();

    while (uniqueNumbers.length < _questions.length) {
      uniqueNumbers.add(random.nextInt(_questions.length));
    }
    List<int> randomNumbers = uniqueNumbers.toList();
    for (int number in randomNumbers) {
      _hints.add(_questions[number].answer);
    }
    _imgHint = _hints[0];
    StartAnimation();
  }

  void checkAnswer(String answer) {
    setState(() {
      if (answer == _questions[_question_no].answer) {
        _point += 25;
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
          _imgHint = _hints[(_hitungAnimasi/3).ceil()];
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
                    Text("Point : " + _point.toString()),
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
                              _questions[_question_no].img_a,
                              width: _imgWidth,
                              height: _imgHeight,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              checkAnswer(_questions[_question_no].img_b);
                            },
                            icon: Image.asset(
                              _questions[_question_no].img_b,
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
                              _questions[_question_no].img_c,
                              width: _imgWidth,
                              height: _imgHeight,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              checkAnswer(_questions[_question_no].img_d);
                            },
                            icon: Image.asset(
                              _questions[_question_no].img_d,
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
    // int top_point = 0;
    // String active_user = "";
    // checkTopPoint().then((int result) {
    //   top_point = result;
    // });
    // if (_point > top_point) {
    //   checkUser().then((String result) {
    //     setTopUser(result, _point);
    //   });
    // }
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
                    // Navigator.pop(context);
                    Navigator.popAndPushNamed(context, 'hasil');
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
    getHighscore(_point);
  }
}

String formatTime(int hitung) {
  var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
  var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
  var seconds = (hitung % 60).toString().padLeft(2, '0');
  return "$hours:$minutes:$seconds";
}
