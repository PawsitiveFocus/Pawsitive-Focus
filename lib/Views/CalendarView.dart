import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendarView extends StatefulWidget {
  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<MyCalendarView> {
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

          ),
        ],
      ),
    );
  }
}