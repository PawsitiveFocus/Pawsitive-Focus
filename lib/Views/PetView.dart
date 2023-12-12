import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/PetViewModel.dart';

class MyPetView extends StatefulWidget {
  final PetViewModel viewModel;
  MyPetView({Key? key, required this.viewModel}) : super(key: key);

  @override
  PetViewState createState() => PetViewState();
}

class PetViewState extends State<MyPetView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar properties
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.viewModel.onImageTapped();
                });
              },
              child: Image.asset(
                'lib/Resources/scoobydoo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20), // Spacer
            Text(
              'Happiness: ${widget.viewModel.happiness}',
              style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            ),
            SizedBox(height: 10), // Spacer
            Text(
              'Money: ${widget.viewModel.money}',
              style: TextStyle(fontSize: 18, color: Colors.greenAccent),
            ),
          ],
        ),
      ),
    );
  }
}
