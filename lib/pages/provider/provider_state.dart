import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_app/pages/provider/dart_selector.dart';

class ProviderState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Multiprovider
    return ChangeNotifierProvider<DartSelector>(
      create: (BuildContext context) => DartSelector(initialValue: 10.0),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Provider State Management'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[MyChart(), MySlider()],
          ),
        ),
      ),
    );
  }
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('My chart provider state build');
    return Container(
      child: PieChart(
        _getChartData(context.watch<DartSelector>().dartValue),
        swapAnimationDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  PieChartData _getChartData(double dartValue) {
    return PieChartData(
      sections: <PieChartSectionData>[
        PieChartSectionData(value: 1, color: Colors.green, title: 'C#'),
        PieChartSectionData(value: 2, color: Colors.teal, title: 'Java'),
        PieChartSectionData(value: 3, color: Colors.blueGrey, title: 'Go'),
        PieChartSectionData(value: 4, color: Colors.red, title: 'Python'),
        PieChartSectionData(
            value: dartValue, color: Colors.blue, title: 'Dart'),
      ],
    );
  }
}

class MySlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double value = context.watch<DartSelector>().dartValue;
    return Container(
      child: Column(
        children: <Widget>[
          Slider(
            divisions: 99,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            min: 0,
            max: 100,
            value: value,
            onChanged: (double sliderValue) {
              context.read<DartSelector>().dartValue = sliderValue;
            },
          ),
        ],
      ),
    );
  }
}
