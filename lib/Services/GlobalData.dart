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
}
