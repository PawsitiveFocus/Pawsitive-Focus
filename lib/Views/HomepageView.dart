import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/HomepageViewModel.dart';


class HomepageView extends StatefulWidget {
  @override
  HomepageViewState createState() => HomepageViewState();
}

class HomepageViewState extends State<HomepageView> {
  final HomepageViewModel viewModel = HomepageViewModel();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: viewModel.tasks.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(viewModel.tasks[index]), // Unique key for each item
            direction: DismissDirection.horizontal,
            onDismissed: (direction) {
              int deletedIndex = index; // Capture the current index in a local variable
              setState(() {
                viewModel.deleteTask(deletedIndex); // Call the deleteTask method from the view model
              });
            },
            background: Container(
              color: Colors.red, // Background color when swiping starts
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: ListTile(
              title: Text(viewModel.tasks[index]),
            ),
            // ... other properties remain the same
          );
        },
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