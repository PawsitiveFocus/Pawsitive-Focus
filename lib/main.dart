import 'package:flutter/material.dart';
import 'package:pawsitivefocus/Models/HomepageModel.dart';
import 'package:pawsitivefocus/Views/CalendarView.dart';
import 'package:pawsitivefocus/Views/HomepageView.dart';
import 'package:pawsitivefocus/Views/HomepageView.dart';
import 'package:pawsitivefocus/Views/PetView.dart';
import 'package:pawsitivefocus/Views/SettingView.dart';


import 'Models/CalendarModel.dart';
import 'Models/PetModel.dart';
import 'ViewModels/CalendarViewModel.dart';
import 'ViewModels/HomepageViewModel.dart';
import 'ViewModels/PetViewModel.dart';




void main() => runApp(const NavigationBarApp());



class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});




  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Navigation());
  }
}




class Navigation extends StatefulWidget {
  const Navigation({super.key});




  @override
  State<Navigation> createState() => _NavigationState();
}




class _NavigationState extends State<Navigation> {
  int currentPageIndex = 0;
  final PetViewModel petViewModel = PetViewModel(PetModel(name: 'Buddy', happiness: 50, money: 100));
  final CalendarViewModel calendarViewModel = CalendarViewModel();
  final HomepageViewModel homepageViewModel = HomepageViewModel();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.lightBlueAccent[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets),
            label: 'Pet',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),




        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: HomepageView(viewModel: homepageViewModel),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: MyCalendarView(viewModel: calendarViewModel),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: PetView(viewModel: petViewModel),
        ),
        Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: SettingView(),
        ),
      ][currentPageIndex],
    );
  }
}



