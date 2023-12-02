import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/FocusPageViewModel.dart';
import 'dart:async';

class FocusPageView extends StatefulWidget {
  @override
  _FocusPageViewState createState() => _FocusPageViewState();
}

class _FocusPageViewState extends State<FocusPageView> {
  final FocusPageViewModel viewModel = FocusPageViewModel();



  @override
  void dispose() {
    viewModel.cancelTimer();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    viewModel.startTimer();
    viewModel.onCountdownComplete = _onCountdownComplete;
  }

  void _onCountdownComplete() {
    Navigator.pop(context); // Return to main page
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
                return Text(
                  'Time Left: ${snapshot.data ?? 300} seconds',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), // Return to main page
              child: Text('Forced Quit'),
            ),
          ],
        ),
      ),
    );
  }
}


