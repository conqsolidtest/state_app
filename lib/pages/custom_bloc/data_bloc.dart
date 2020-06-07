import 'dart:async';

import 'package:conq_state_app/pages/custom_bloc/bloc.dart';

class DataBloc extends Bloc {
  final _dataValueController = StreamController<double>();

  Stream<double> get dataValueStream => _dataValueController.stream;
  
  void setDataValue(double value) {
    _dataValueController.sink.add(value);
  }

  @override
  void dispose() {
    _dataValueController.close();
  }
}
