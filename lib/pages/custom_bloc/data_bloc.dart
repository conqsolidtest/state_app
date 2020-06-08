import 'dart:async';

import 'package:state_app/pages/custom_bloc/bloc.dart';

class DataBloc extends Bloc {
  final double initialValue;
  final _dataValueController = StreamController<double>.broadcast();

  double _dataValue;

  DataBloc(this.initialValue) {
    this._dataValue = initialValue;
  }

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
