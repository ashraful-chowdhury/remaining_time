import 'dart:async';

import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: const Center(
        child: TimerWidget(),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final quizStartTime = DateTime.parse("2023-11-30 20:00:00");
  Duration? timeLeft;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          timeLeft = quizStartTime.difference(DateTime.now());
        });

        if (timeLeft!.isNegative) {
          // Todo: A pop-up should be displayed here
          timer.cancel();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timeLeft == null) return const CircularProgressIndicator();
    final timeLeftInfoText =
        '${timeLeft!.inHours}: ${(timeLeft!.inMinutes % 60).toString().padLeft(2, '0')}: ${(timeLeft!.inSeconds % 60).toString().padLeft(2, '0')}';
    return Text('Remaining Time - $timeLeftInfoText');
  }
}
