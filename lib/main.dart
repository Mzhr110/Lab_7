import 'package:flutter/material.dart';

void main() {
  runApp(TimerApp());
}

class TimerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Timer App', home: TimerHomePage());
  }
}

class TimerHomePage extends StatefulWidget {
  @override
  _TimerHomePageState createState() => _TimerHomePageState();
}

class _TimerHomePageState extends State<TimerHomePage> {
  int _timeLeft = 10; // Countdown starting value
  bool _isRunning = false;

  Future<void> startTimer() async {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
      _timeLeft = 10;
    });

    for (int i = _timeLeft; i > 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _timeLeft--;
      });
    }

    setState(() {
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Timer App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_timeLeft',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: startTimer,
              child: Text(_isRunning ? 'Counting...' : 'Start Timer'),
            ),
          ],
        ),
      ),
    );
  }
}
