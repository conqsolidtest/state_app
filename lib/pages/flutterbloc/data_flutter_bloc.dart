import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class DataFlutterBloc extends Bloc<DataOperation, double> {
  @override
  double get initialState => 10.0;

  @override
  Stream<double> mapEventToState(DataOperation event) async* {
    if (event is SetData) {
      yield event.newDataValue;
    }
  }
}

abstract class DataOperation {}

class SetData extends DataOperation {
  SetData({this.newDataValue});
  double newDataValue;
}

abstract class DataState {}

class DataFetched extends DataState {
  DataFetched(this.value);
  final double value;
}

class DataInitial extends DataState {}

class DataWaiting extends DataState {}
