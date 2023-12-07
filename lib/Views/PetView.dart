import 'package:flutter/material.dart';
import 'package:pawsitivefocus/ViewModels/PetViewModel.dart';

import 'package:fl_chart/fl_chart.dart';

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
                  widget.viewModel.onImageTapped(); // Now wrapped in setState to update the UI
                });
              },
              child: Image.asset(
                'lib/Resources/scoobydoo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height:200,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          y: widget.viewModel.happiness.toDouble(),
                          colors: [Colors.blueAccent],
                          width:22,
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          y: widget.viewModel.money.toDouble(),
                          colors: [Colors.greenAccent],
                          width:22,
                        ),
                      ],
                    ),
                  ],
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (double value) {
                        switch (value.toInt()) {
                          case 0:
                            return 'Happiness';
                          case 1:
                            return 'Money';
                          default:
                            return '';
                        }
                      },
                      margin: 8,
                      getTextStyles: (context, value) => const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    leftTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
