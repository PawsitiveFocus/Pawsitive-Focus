class PetModel {
  String name;
  int happiness;
  int money;

  PetModel({required this.name, this.happiness = 0, this.money = 0});


  void decreaseMoney() {
    if (money > 5 && happiness < 100) {
      money -= 5;
    }
    // print("money");
    // print(money);
  }

  void changeHappiness() {
    if (happiness < 100 && money > 0) {
      happiness += 5;
    }
    // print("hap: ");
    // print(happiness);
  }

  void addMoney(int moreMoney){
    money += moreMoney;
    // print("dollar: ");
    // print(money);
  }
}
