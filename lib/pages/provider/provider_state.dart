import 'package:conq_state_app/pages/provider/dart_selector.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DartSelector>(
      create: (context) => DartSelector(initialValue: 10.0),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Provider State Management'),
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
    return Container(
      child: PieChart(
        _getInitialData(context.watch<DartSelector>().dartValue),
        swapAnimationDuration: Duration(milliseconds: 500),
      ),
    );
  }

  PieChartData _getInitialData(double dartValue) {
    return PieChartData(
      sections: [
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
    var value = context.watch<DartSelector>().dartValue;
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
            onChanged: (sliderValue) {
              context.read<DartSelector>().dartValue = sliderValue;
            },
          ),
        ],
      ),
    );
  }
}
