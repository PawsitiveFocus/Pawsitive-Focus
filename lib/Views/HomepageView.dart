import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/HomepageViewModel.dart';

TimeOfDay selectedTime = TimeOfDay.now();

class HomepageView extends StatefulWidget {
  @override
  HomepageViewState createState() => HomepageViewState();
}

class HomepageViewState extends State<HomepageView> {
  final HomepageViewModel viewModel = HomepageViewModel();

  // Pop up to add new task
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
                  viewModel.addTask(newTask);
                  setState(() {}); // Trigger a rebuild of the widget tree
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setFocusTime(BuildContext context) {

    final TimeOfDay timePicked =  showTimePicker(
      context: context,
      initialTime: selectedTime,
    ) as TimeOfDay;

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
                      // viewModel.setFocusTime(selectedHours, selectedMinutes);
                    },
                    child: const Text('Start'),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.tasks.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Dismissible(
                      key: Key(viewModel.tasks[index]),
                      direction: DismissDirection.horizontal,
                      onDismissed: (direction) {
                        setState(() {
                          viewModel.deleteTask(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      child: ListTile(
                        title: Text(viewModel.tasks[index]),
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
