import 'dart:math';

import 'package:state_app/pages/simple_bloc/data_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SimpleBloc extends StatelessWidget {
  final _dataBloc = DataBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc State Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MyChart(dataBloc: _dataBloc),
            MySlider(dataBloc: _dataBloc),
          ],
        ),
      ),
    );
  }
}

class MyChart extends StatelessWidget {

  final DataBloc dataBloc;

  MyChart({@required this.dataBloc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var d = Random().nextDouble() * 100;
        dataBloc.dispatch(SetData(newDataValue: d));
      },
      child: StreamBuilder<double>(
          stream: dataBloc.dataStream,
          initialData: 10,
          builder: (ctx, AsyncSnapshot<double> snapshot) {
            if (snapshot.hasData) {
              return PieChart(
                _getChartData(snapshot.data),
                swapAnimationDuration: Duration(milliseconds: 500),
              );
            }
            return PieChart(
              _getChartData(0),
              swapAnimationDuration: Duration(milliseconds: 500),
            );
          }),
    );
  }

  PieChartData _getChartData(double dartValue) {
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
  final DataBloc dataBloc;

  const MySlider({Key key, @required this.dataBloc}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder<double>(
              stream: dataBloc.dataStream,
              initialData: 10.0,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Slider(
                    divisions: 99,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 100,
                    value: snapshot.data,
                    onChanged: (sliderValue) {
                      dataBloc.dispatch(SetData(newDataValue: sliderValue));
                    },
                  );
                }
                return Slider(
                  divisions: 99,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  min: 0,
                  max: 100,
                  value: 10,
                  onChanged: (sliderValue) {
                    dataBloc.dispatch(SetData(newDataValue: sliderValue));
                  },
                );
              }),
        ],
      ),
    );
  }
}
