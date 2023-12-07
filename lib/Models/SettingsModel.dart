import 'package:flutter/material.dart';

class SettingsModel{
bool petViewOn = true;
bool darkModeOn = false;

SettingsModel(this.petViewOn, this.darkModeOn);

bool getPetViewOn(){
  return petViewOn;
}

void setPetView(){
  petViewOn = !petViewOn;
}

bool getDarkModeOn(){
  return darkModeOn;
}

void setDarkMode(){
  darkModeOn = !darkModeOn;
}

}