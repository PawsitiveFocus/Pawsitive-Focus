import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pawsitivefocus/Models/HomepageModel.dart';
import 'package:pawsitivefocus/Models/SettingsModel.dart';
import 'package:pawsitivefocus/Views/CalendarView.dart';
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
  final SettingsModel settingsModel = SettingsModel(false, false);

  @override
  Widget build(BuildContext context) {
    // Wrap your MaterialApp with a ChangeNotifierProvider
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            // Use the theme based on dark mode status
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: Scaffold(
              bottomNavigationBar: NavigationBar(
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                indicatorColor: Colors.lightBlueAccent[800],
                selectedIndex: currentPageIndex,
                destinations: <Widget>[
                  const NavigationDestination(
                    selectedIcon: Icon(Icons.home),
                    icon: Icon(Icons.home_outlined),
                    label: 'Home',
                  ),
                  const NavigationDestination(
                    selectedIcon: Icon(Icons.calendar_month),
                    icon: Icon(Icons.calendar_month_outlined),
                    label: 'Calendar',
                  ),
                  if (!settingsModel.getPetViewOn())
                    const NavigationDestination(
                      icon: Icon(Icons.pets),
                      label: 'Pet',
                    ),
                  const NavigationDestination(
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
                if (!settingsModel.getPetViewOn())
                  Container(
                    color: Colors.white,
                    alignment: Alignment.center,
                    child: PetView(viewModel: petViewModel),
                  ),
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: SettingView(model: settingsModel),
                ),
              ][currentPageIndex],
            ),
          );
        },
      ),
    );
  }
}

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}



