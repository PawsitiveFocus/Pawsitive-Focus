import 'package:pawsitivefocus/Models/PetModel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';

class PetViewModel extends ChangeNotifier {
  final PetModel _petModel;

  PetViewModel(this._petModel);

  int get happiness => _petModel.happiness;
  int get money => _petModel.money;

  // void onImageTapped() {
  //   print(happiness);
  //   print(money);
  //   _petModel.decreaseMoney();
  //   _petModel.changeHappiness();
  //   notifyListeners();
  // }

  void onImageTapped() {
    _petModel.changeHappiness();
    _petModel.decreaseMoney();
    notifyListeners();
  }

  void test() {
    _petModel.changeHappiness();
    _petModel.decreaseMoney();
    notifyListeners();
  }


}
