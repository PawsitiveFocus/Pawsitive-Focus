import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pawsitivefocus/Models/SettingsModel.dart';

import '../main.dart';

class SettingView extends StatefulWidget {
  final SettingsModel model;

  SettingView({Key? key, required this.model}) : super(key: key);

  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
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
              value: widget.model.getPetViewOn(),
              onChanged: (value) {
                setState(() {
                  widget.model.setPetView();
                });
              },
            ),
          ),
          ListTile(
            title: Text('Night mode'),
            trailing: Switch(
              value: widget.model.getDarkModeOn(),
              onChanged: (value) {
                setState(() {
                  widget.model.setDarkMode();
                  // Use the Provider package to notify listeners of the change
                  Provider.of<ThemeProvider>(context, listen: false).setDarkMode(value);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}