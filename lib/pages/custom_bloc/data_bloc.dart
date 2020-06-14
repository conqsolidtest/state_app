import 'dart:async';

import 'package:state_app/pages/custom_bloc/bloc.dart';

class DataBloc extends Bloc {
  DataBloc(this.initialValue) {
    _dataValue = initialValue;
  }
  final double initialValue;
  final StreamController<double> _dataValueController =
      StreamController<double>.broadcast();

  double _dataValue;

  Stream<double> get dataValueStream => _dataValueController.stream;
  double get dataValue => _dataValue;

  void setDataValue(double value) {
    _dataValue = value;
    _dataValueController.sink.add(value);
  }

  @override
  void dispose() {
    _dataValueController.close();
  }
}
