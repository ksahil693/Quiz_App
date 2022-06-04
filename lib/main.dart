import 'package:flutter/material.dart';
import 'package:quiz/questionBank.dart';
import 'package:alert/alert.dart';

QuestionBank que = QuestionBank();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Icon> ScoreKeeper = [];

  void CheckAnswer(bool userPickedAnswer) {
    setState(() {
      if (que.isFinished() == true) {
        Alert(
          message: 'You\'ve reached the end of the quiz.',
          shortDuration: true,
        ).show();
        que.reset();
        ScoreKeeper = [];
      } else {
        if (userPickedAnswer == que.qAnswer()) {
          ScoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          ScoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        que.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  que.qText(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {
                  CheckAnswer(true);
                },
                color: Colors.green,
                child: Text("True"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: FlatButton(
                onPressed: () {
                  CheckAnswer(false);
                },
                color: Colors.red,
                child: Text("False"),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: ScoreKeeper,
            ),
          )
        ],
      ),
    );
  }
}
