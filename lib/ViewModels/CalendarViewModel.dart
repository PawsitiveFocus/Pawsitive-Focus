import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../Models/CalendarModel.dart';

class CalendarViewModel extends ChangeNotifier{
  final CalendarModel _model = CalendarModel();

  List<Appointment> get appointments => _model.appointments;

  void addAppointment(String eventName, DateTime date, TimeOfDay startTime, TimeOfDay endTime, String location, Color eventColor) {

    DateTime startDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      startTime.hour,
      startTime.minute,
    );

    DateTime endDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      endTime.hour,
      endTime.minute,
    );

    _model.appointments.add(
      Appointment(
        startTime: startDateTime,
        endTime: endDateTime,
        subject: eventName,
        color: eventColor,
        location: location,

      ),
    );
    notifyListeners();
  }
  void deleteAppointment(int index) {
    if (index >= 0 && index < _model.appointments.length) {
      _model.appointments.removeAt(index);
      notifyListeners();
    }
  }
}
