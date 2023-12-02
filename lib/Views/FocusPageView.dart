import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/FocusPageViewModel.dart';
import 'dart:async';

class FocusPageView extends StatefulWidget {
  final int initialCountdown;

  FocusPageView({Key? key, required this.initialCountdown}) : super(key: key);

  @override
  _FocusPageViewState createState() => _FocusPageViewState();
}

class _FocusPageViewState extends State<FocusPageView> {
  late FocusPageViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = FocusPageViewModel(initialCountdownTime: widget.initialCountdown);
    viewModel.startTimer();
    viewModel.onCountdownComplete = _onCountdownComplete;
  }

  void _onCountdownComplete() {
    Navigator.pop(context); // Return to main page
  }

  @override
  void dispose() {
    viewModel.cancelTimer();
    super.dispose();
  }

  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Focus Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<DateTime>(
              stream: viewModel.timeStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Text(
                  'Current Time: ${snapshot.data!.hour}:${snapshot.data!.minute}:${snapshot.data!.second}',
                  style: TextStyle(fontSize: 35),
                );
              },
            ),
            SizedBox(height: 20),
            StreamBuilder<int>(
              stream: viewModel.moneyStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Text(
                  'Money: \$${snapshot.data}',
                  style: TextStyle(fontSize: 24, color: Colors.green),
                );
              },
            ),
            StreamBuilder<int>(
              stream: viewModel.countdownStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Text(
                  'Time Left: ${formatTime(snapshot.data ?? 0)}',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Forced Quit'),
            ),
          ],
        ),
      ),
    );
  }
}
