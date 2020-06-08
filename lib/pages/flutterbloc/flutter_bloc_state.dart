import 'package:state_app/pages/flutterbloc/data_flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlutterBlocState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Bloc State')),
      body: BlocProvider<DataFlutterBloc>(
        create: (context) => DataFlutterBloc(),
        child: Center(
          child: Column(
            children: <Widget>[MyChart(), MySlider()],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
        ),
      ),
    );
  }
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataFlutterBloc, double>(
      builder: (context, state) {
        return PieChart(
          _getChartData(state),
          swapAnimationDuration: Duration(milliseconds: 500),
        );
      },
    );
  }

  PieChartData _getChartData(double dartValue) {
    return PieChartData(
      pieTouchData: PieTouchData(enabled: true),
      sections: [
        PieChartSectionData(value: 10, color: Colors.green, title: 'C#'),
        PieChartSectionData(value: 15, color: Colors.teal, title: 'Java'),
        PieChartSectionData(value: 20, color: Colors.blueGrey, title: 'Go'),
        PieChartSectionData(value: 25, color: Colors.red, title: 'Python'),
        PieChartSectionData(
            value: dartValue, color: Colors.blue, title: 'Dart'),
      ],
    );
  }
}

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  DataFlutterBloc _myBloc;

  @override
  Widget build(BuildContext context) {
    _myBloc = BlocProvider.of<DataFlutterBloc>(context);

    return BlocBuilder<DataFlutterBloc, double>(
      builder: (context, state) {
        return Container(
          child: Slider(
            divisions: 99,
            activeColor: Colors.blue,
            inactiveColor: Colors.grey,
            min: 0,
            max: 100,
            value: state,
            onChanged: (sliderValue) {
              _myBloc.add(SetData(newDataValue: sliderValue));
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _myBloc.close();
    super.dispose();
  }
}
