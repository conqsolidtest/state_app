import 'package:state_app/pages/custom_bloc/bloc_provider.dart';
import 'package:state_app/pages/custom_bloc/data_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Custom Bloc')),
        body: BlocProvider<DataBloc>(
          bloc: DataBloc(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MyChart(),
              MySlider(),
            ],
          ),
        ));
  }
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DataBloc>(context);
    return StreamBuilder<double>(
        stream: bloc.dataValueStream,
        builder: (ctx, AsyncSnapshot<double> snapshot) {
          return PieChart(
            _getChartData(bloc.dataValue),
            swapAnimationDuration: Duration(milliseconds: 500),
          );
        });
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
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DataBloc>(context);

    return Container(
      child: Column(
        children: <Widget>[
          StreamBuilder<double>(
              stream: bloc.dataValueStream,
              builder: (context, snapshot) {
                return Slider(
                  divisions: 99,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  min: 0,
                  max: 100,
                  value: bloc.dataValue,
                  onChanged: (sliderValue) {
                    bloc.setDataValue(sliderValue);
                  },
                );
              }),
        ],
      ),
    );
  }
}
