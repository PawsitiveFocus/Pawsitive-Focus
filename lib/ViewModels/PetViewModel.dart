import 'package:pawsitivefocus/Models/PetModel.dart';

class PetViewModel {
  final PetModel _petModel;

  PetViewModel(this._petModel);

  // Getters for happiness and money
  int get happiness => _petModel.happiness;
  int get money => _petModel.money;

  // Other methods and logic...

  void onImageDoubleTapped() {
    _petModel.decreaseMoney();
    _petModel.changeHappiness();
    // Notify listeners if necessary
  }
}
