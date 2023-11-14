import 'package:pawsitivefocus/Models/HomepageModel.dart';

class HomepageViewModel {
  final HomepageModel _model = HomepageModel();

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
  int setFocusTime(int hours, int minutes){
    int total_minutes = (hours * 60) + minutes;
    return total_minutes;
  }
}
