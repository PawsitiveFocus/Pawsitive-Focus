import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:pawsitivefocus/ViewModels/CalendarViewModel.dart';
import 'package:pawsitivefocus/Models/CalendarModel.dart';



class MyCalendarView extends StatefulWidget {
  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<MyCalendarView> {
  final CalendarViewModel viewModel = CalendarViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container( //for top half of page
            height: MediaQuery.of(context).size.height * 0.4, // Take up half of the screen height
            child: SfCalendar(
              view: CalendarView.month,
            ),
          ),
          Container( //for bottom half of page
            height: MediaQuery.of(context).size.height * 0.6, // Take up half of the screen height
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
    );
  }
}