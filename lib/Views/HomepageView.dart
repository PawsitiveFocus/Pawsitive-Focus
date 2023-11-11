import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/HomepageViewModel.dart';
import 'package:numberpicker/numberpicker.dart';

class HomepageView extends StatefulWidget {
  @override
  HomepageViewState createState() => HomepageViewState();
}

class HomepageViewState extends State<HomepageView> {
  final HomepageViewModel viewModel = HomepageViewModel();
  int selectedHours = 0;
  int selectedMinutes = 0;

  //pop up to add new task
  void showAddTaskDialog(BuildContext context) {
    String newTask = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a New Task'),
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

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Focus Duration'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NumberPicker(
                  value: selectedHours,
                  minValue: 0,
                  maxValue: 23,
                  onChanged: (value) => setState(() => selectedHours = value),
                ),
                Text('hours'),
                NumberPicker(
                  value: selectedMinutes,
                  minValue: 0,
                  maxValue: 59,
                  onChanged: (value) => setState(() => selectedMinutes = value),
                ),
                Text('mins'),
              ],
            ),
            actions: <Widget>[
              // ... actions ...
            ],
          );
        },
      );




    /*
    TimeOfDay selectedTime = TimeOfDay.now(); // Default or previously selected time

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Focus Popup'),
          content: Text('Select a focus time.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Pick Time'),
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );

                if (picked != null && picked != selectedTime) {
                  // Do something with the picked time
                  // For example, update the state or store the time
                  setState(() {
                    selectedTime = picked;
                  });
                  // You can also close the dialog if needed
                  // Navigator.of(context).pop();
                }
              },
            ),
            ElevatedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
    */
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: FloatingActionButton(
              onPressed: () {
                setFocusTime(context);
              },
              child: Icon(Icons.add),
              tooltip: 'Focus',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                // Add your functionality here
              },
              child: Text('Start'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
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
        child: Icon(Icons.add),
      ),
    );
  }

}