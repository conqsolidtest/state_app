import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LocalState extends StatefulWidget {
  @override
  _LocalStateState createState() => _LocalStateState();
}

class _LocalStateState extends State<LocalState> {
  double _dartValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local State Management'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          PieChart(
            _getChartData(),
            swapAnimationDuration: Duration(milliseconds: 500),
          ),
          Column(
            children: <Widget>[
              Slider(
                divisions: 100,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                min: 0,
                max: 100,
                value: _dartValue,
                onChanged: (sliderValue) {
                  setState(() {
                    _dartValue = sliderValue;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  PieChartData _getChartData() {
    return PieChartData(
      sections: [
        PieChartSectionData(value: 1, color: Colors.green, title: 'C#'),
        PieChartSectionData(value: 2, color: Colors.teal, title: 'Java'),
        PieChartSectionData(value: 3, color: Colors.blueGrey, title: 'Go'),
        PieChartSectionData(value: 4, color: Colors.red, title: 'Python'),
        PieChartSectionData(
            value: _dartValue, color: Colors.blue, title: 'Dart'),
      ],
    );
  }
}
