import 'package:flutter/material.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  bool petModelSwitchValue = true;
  bool languageSwitchValue = false;
  bool nightModeSwitchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Turn off pet model'),
            trailing: Switch(
              value: petModelSwitchValue,
              onChanged: (value) {
                setState(() {
                  petModelSwitchValue = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Change the language'),
            trailing: Switch(
              value: languageSwitchValue,
              onChanged: (value) {
                setState(() {
                  languageSwitchValue = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Night mode'),
            trailing: Switch(
              value: nightModeSwitchValue,
              onChanged: (value) {
                setState(() {
                  nightModeSwitchValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}