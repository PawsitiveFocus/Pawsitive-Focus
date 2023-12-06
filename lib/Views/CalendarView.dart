import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:pawsitivefocus/Models/CalendarModel.dart';
import 'package:pawsitivefocus/ViewModels/CalendarViewModel.dart';
import 'package:intl/intl.dart';

class MyCalendarView extends StatefulWidget {
  final CalendarViewModel viewModel;
  MyCalendarView({Key? key, required this.viewModel}) : super(key: key);

  @override
  CalendarViewState createState() => CalendarViewState();
}

class CalendarViewState extends State<MyCalendarView> {
  String selectedDateText = 'Pick Date';
  String selectedStartTimeText = 'Start Time';
  String selectedEndTimeText = 'End Time';

  // GlobalKey for rebuilds
  final GlobalKey<_MyCalendarViewState> _calendarKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            title: const Text("Calendar"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _showAddEventDialog(context);
                },
              ),
            ],
          ),
          Expanded(
            child: MyCalendarViewStateful(
              key: _calendarKey,
              viewModel: widget.viewModel,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddEventDialog(BuildContext context) {
    TextEditingController eventNameController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedStartTime = TimeOfDay.now();
    TimeOfDay selectedEndTime = TimeOfDay.now();
    TextEditingController locationController = TextEditingController();
    String selectedColor = 'amber';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Event'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: eventNameController,
                      decoration: const InputDecoration(labelText: 'Event Name'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(labelText: 'Location'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        ).then((pickedDate) {
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                              selectedDateText = 'Date: ${DateFormat('yyyy-MM-dd').format(pickedDate)}';
                            });
                          }
                        });
                      },
                      child: Text(selectedDateText),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: selectedStartTime,
                            ).then((pickedTime) {
                              if (pickedTime != null) {
                                setState(() {
                                  selectedStartTime = pickedTime;
                                  selectedStartTimeText = 'Start time: ${pickedTime.format(context)}';
                                });
                              }
                            });
                          },
                          child: Text(selectedStartTimeText),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showTimePicker(
                              context: context,
                              initialTime: selectedEndTime,
                            ).then((pickedTime) {
                              if (pickedTime != null) {
                                setState(() {
                                  selectedEndTime = pickedTime;
                                  selectedEndTimeText = 'End time: ${pickedTime.format(context)}';
                                });
                              }
                            });
                          },
                          child: Text(selectedEndTimeText),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('Color:'),
                    DropdownButton<String>(
                      value: selectedColor,
                      onChanged: (String? value) {
                        setState(() {
                          selectedColor = value!;
                        });
                      },
                      items: ['amber', 'pink', 'blue', 'purple']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                          .toList(),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    widget.viewModel.addAppointment(
                      eventNameController.text,
                      selectedDate,
                      selectedStartTime,
                      selectedEndTime,
                      locationController.text,
                      _getColor(selectedColor),
                    );

                    // Force a rebuild of the calendar
                    _calendarKey.currentState?.forceRebuild();

                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Add'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'amber':
        return Colors.amber;
      case 'pink':
        return Colors.pink;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      default:
        return Colors.amber;
    }
  }
}

class _DataSource extends CalendarDataSource {
  final CalendarViewModel viewModel;

  _DataSource(List<Appointment> source, this.viewModel) : super() { //updated constructor to accept id
    appointments = source.map((appointment) {
      final index = source.indexOf(appointment);
      return Appointment(
        startTime: appointment.startTime,
        endTime: appointment.endTime,
        subject: appointment.subject,
        color: appointment.color,
        location: appointment.location,
        isAllDay: appointment.isAllDay,
        notes: appointment.notes,
        startTimeZone: appointment.startTimeZone,
        endTimeZone: appointment.endTimeZone,
        recurrenceId: appointment.recurrenceId,
        resourceIds: appointment.resourceIds,
        id: index.toString(),
      );
    }).toList();
  }
}

class MyCalendarViewStateful extends StatefulWidget {
  final CalendarViewModel viewModel;

  const MyCalendarViewStateful({Key? key, required this.viewModel}) : super(key: key);

  @override
  _MyCalendarViewState createState() => _MyCalendarViewState();
}

class _MyCalendarViewState extends State<MyCalendarViewStateful> {
  void forceRebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {

      },
      child: SfCalendar(
        view: CalendarView.month,
        initialDisplayDate: DateTime.now(),
        dataSource: _DataSource(
            widget.viewModel.appointments, widget.viewModel),
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          showAgenda: true,
        ),
        onTap: (CalendarTapDetails details) {
          if (details.targetElement == CalendarElement.appointment) {
            int selectedEventIndex = int.parse(
                details.appointments![0].id ?? '-1');
            _showDeleteEventDialog(context, selectedEventIndex);
          }
        },
      ),
    );
  }

  void _showDeleteEventDialog(BuildContext context, int selectedEventIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Event'),
          content: const Text('Are you sure you want to delete this event?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                widget.viewModel.deleteAppointment(selectedEventIndex);
                // Trigger a rebuild after deleting the event
                setState(() {});
                // Close the dialog
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}