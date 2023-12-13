import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/FocusPageViewModel.dart';
import 'package:pawsitivefocus/Models/PetModel.dart';
import 'dart:async';
import 'package:pawsitivefocus/Views/HomepageView.dart';
import 'package:pawsitivefocus/ViewModels/HomepageViewModel.dart';

// class FocusPageView extends StatefulWidget {
//   final int initialCountdown;
//
//   FocusPageView({Key? key, required this.initialCountdown}) : super(key: key);
//
//   @override
//   _FocusPageViewState createState() => _FocusPageViewState();
// }

class FocusPageView extends StatefulWidget {
  final int initialCountdown;
  final HomepageViewModel homepageViewModel; // Add this line

  FocusPageView({
    Key? key,
    required this.initialCountdown,
    required this.homepageViewModel, // Add this line
  }) : super(key: key);

  @override
  _FocusPageViewState createState() => _FocusPageViewState();
}

class _FocusPageViewState extends State<FocusPageView> {
  late FocusPageViewModel viewModel;

  @override
  void initState() {
    super.initState();
    final petModel = PetModel(name: "Scooby", happiness: 50, money: 100);
    viewModel = FocusPageViewModel(initialCountdownTime: widget.initialCountdown, petModel: petModel);
    viewModel.startTimer();
    viewModel.onCountdownComplete = _onCountdownComplete;
  }

  void _onCountdownComplete() {
    Navigator.pop(context); // Return to main page
  }

  @override
  void dispose() {
    viewModel.cancelTimer();
    print("test");
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
      appBar: AppBar(
          title: Text('Focus Page'),
          leading: Container(),  // Add an empty Container as leading widget
          automaticallyImplyLeading: false,  // Set this to false
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Turn on and keep Focus Mode',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirmation'),
                      content: Text('Are you sure you want to quit?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: const Text('Quit'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/',
                                  (route) => false, // Remove all routes from the stack
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Forced Quit'),
            ),

          ],
        ),
      ),
    );
  }
}
