import 'package:conq_state_app/pages/custom_bloc/bloc_provider.dart';
import 'package:conq_state_app/pages/custom_bloc/data_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Custom Bloc')),
        body: BlocProvider<DataBloc>(
          bloc: DataBloc(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[MyChart(), MySlider()],
          ),
        ));
  }
}

class MyChart extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<DataBloc>(context);
    return StreamBuilder<double>(
        stream: bloc.dataValueStream,
        builder: (ctx, AsyncSnapshot<double> snapshot) {
          if (snapshot.hasData) {
            return PieChart(
              _getChartData(snapshot.data),
              swapAnimationDuration: Duration(milliseconds: 500),
            );
          }
          return Center(child: Text('Select count'));
        });
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
                if (snapshot.hasData) {
                  return Slider(
                    divisions: 99,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    min: 0,
                    max: 100,
                    value: snapshot.data,
                    onChanged: (sliderValue) {
                      bloc.setDataValue(sliderValue);
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
                    bloc.setDataValue(sliderValue);
                  },
                );
              }),
        ],
      ),
    );
  }
}
