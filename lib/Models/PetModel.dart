class PetModel {
  String name;
  int happiness;
  int money;

  PetModel({required this.name, this.happiness = 0, this.money = 0});

  void decreaseMoney() {
    money = money > 5 ? money - 5 : 0;
  }

  void changeHappiness() {
    happiness = (happiness + 5) % 100;
  }
}
