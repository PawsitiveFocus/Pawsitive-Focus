import '../Models/PetModel.dart';

class GlobalData {
  // Private constructor
  GlobalData._privateConstructor();

  // Static instance of the class
  static final GlobalData _instance = GlobalData._privateConstructor();

  // Factory constructor to return the same instance
  factory GlobalData() {
    return _instance;
  }

  // Default PetModel instance
  final PetModel petModel = PetModel(name: "Scooby", happiness: 50, money: 100);

// Other global variables or methods can be defined here
  final List<String> tasks = [
      'Buy groceries',
      'Finish report for work',
      'Call the doctor',
      'Schedule a haircut',
      'Read a chapter of a book',
      'Go for a jog',
      'Pay bills',
      'Clean the house',
      'Attend team meeting',
  ];

}
