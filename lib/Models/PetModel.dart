class PetModel {
  String name;
  int happiness;
  int money;

  PetModel({required this.name, this.happiness = 0, this.money = 0});

  // void decreaseMoney() {
  //   money = money > 5 ? money - 5 : 0;
  // }
  //
  // void changeHappiness() {
  //   happiness = (happiness + 5) % 100;
  // }

  void decreaseMoney() {
    if (money > 5 && happiness < 100) {
      money -= 5;
    }
    print(money);
    // Notify listeners of the change right here if necessary
    // However, this is usually done in the ViewModel
  }

  void changeHappiness() {
    // happiness = (happiness + 5) % 100;
    // print(happiness);
    if (happiness < 100 && money > 0) {
      happiness += 5;
    }
    print(happiness);
    // Notify listeners of the change right here if necessary
  }
}
