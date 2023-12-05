import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('1.Turn off per model'),
          ),
          ListTile(
            title: Text('2. Change the language '),
          ),
          ListTile(
            title: Text('3. Night mode'),
          ),
        ],
      ),
    );
  }
}
