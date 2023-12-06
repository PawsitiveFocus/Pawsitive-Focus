import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarModel extends ChangeNotifier {
  List<Appointment> appointments;

  CalendarModel({List<Appointment>? initialAppointments})
      : appointments = initialAppointments ?? _getInitialAppointments();

  static List<Appointment> _getInitialAppointments() {
    return [
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        subject: 'Meeting 1',
        color: Colors.pink,
      ),
      Appointment(
        startTime: DateTime.now().add(const Duration(hours: 4)),
        endTime: DateTime.now().add(const Duration(hours: 5)),
        subject: 'Meeting',
        color: Colors.lightBlueAccent,
      ),
      Appointment(
        startTime: DateTime.now().add(const Duration(hours: 6)),
        endTime: DateTime.now().add(const Duration(hours: 7)),
        subject: 'Meeting 3',
        color: Colors.amber,
      ),
      Appointment(
        startTime: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        subject: 'Doctors Appointment',
        color: Colors.amber,
      ),
      Appointment(
        startTime: DateTime.now().add(const Duration(hours: 4)),
        endTime: DateTime.now().add(const Duration(hours: 5)),
        subject: 'Meeting 2',
        color: Colors.lightBlueAccent,
      ),
      Appointment(
        startTime: DateTime.now().add(const Duration(hours: 6)),
        endTime: DateTime.now().add(const Duration(hours: 7)),
        subject: 'Meeting 4',
        color: Colors.lightBlue,
      )
    ];
  }
}
