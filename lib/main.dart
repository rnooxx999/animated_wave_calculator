
import 'package:flutter/material.dart';

import 'wave_calculator.dart';



void main() =>
    runApp(Loading());

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return

      MaterialApp(
        title: 'Loading Page',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WaveCalculator(),


      );
  }
}
