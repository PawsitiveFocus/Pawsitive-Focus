import 'package:pawsitivefocus/Models/CalendarModel.dart';

class CalendarViewModel {
  final CalendarModel _model = CalendarModel();

  List<String> get tasks => _model.tasks;

  void addTask(String newTask) {
    if (newTask.isNotEmpty) {
      _model.tasks.add(newTask);
    }
  }
  void deleteTask(int index) {
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);
    }
  }
}
