import 'package:flutter/material.dart';

class PetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
        ),
        body: Center(
          child: Image.asset(
            'lib/Resources/scoobydoo.png',  // Replace with the actual path to your image file
            fit: BoxFit.cover,    // Set the BoxFit property to control how the image is displayed
          ),
        ),
      ),
    );
  }
}
