import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/HomepageViewModel.dart';
import 'FocusPageView.dart';

class HomepageView extends StatefulWidget {
  final HomepageViewModel viewModel;

  HomepageView({Key? key, required this.viewModel}) : super(key: key);

  @override
  HomepageViewState createState() => HomepageViewState();
}

class HomepageViewState extends State<HomepageView> {
  TimeOfDay selectedTime = TimeOfDay.now();

  void showAddTaskDialog(BuildContext context) {
    String newTask = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a New Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter task name',
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                if (newTask.isNotEmpty) {
                  widget.viewModel.addTask(newTask);
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setFocusTime(BuildContext context) async {
    final TimeOfDay? timePicked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (timePicked != null && timePicked != selectedTime) {
      setState(() {
        selectedTime = timePicked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double buttonSize = MediaQuery.of(context).size.width * 0.4;

                return SizedBox(
                  height: buttonSize,
                  width: buttonSize,
                  child: FloatingActionButton(
                    onPressed: () {
                      setFocusTime(context);
                    },
                    tooltip: 'Focus',
                    child: const Text('Focus'),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                double buttonSize = MediaQuery.of(context).size.width * 0.1;

                return SizedBox(
                  height: buttonSize,
                  width: buttonSize * 2,
                  child: ElevatedButton(
                    onPressed: () {
                      final now = DateTime.now();
                      final currentTime = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
                      final difference = currentTime.difference(now).inMinutes;
                      final seconds = difference * 60;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FocusPageView(initialCountdown: seconds)),
                      );
                    },
                    child: const Text('Start'),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.viewModel.tasks.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Dismissible(
                      key: Key(widget.viewModel.tasks[index]),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        setState(() {
                          widget.viewModel.deleteTask(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(widget.viewModel.tasks[index]),
                      ),
                    ),
                    const Divider(), // Add a horizontal line between ListTiles
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
