import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class DataFlutterBloc extends Bloc<DataOperation, double> {
  @override
  double get initialState => 10.0;

  @override
  Stream<double> mapEventToState(DataOperation event) async*{
    if(event is SetData){
      yield event.newDataValue;
    }
  }
  
  
}

abstract class DataOperation {}

class SetData extends DataOperation {
  double newDataValue;

  SetData({this.newDataValue});
}

abstract class DataState {}

class DataFetched extends DataState {
  final double value;

  DataFetched(this.value);
}

class DataInitial extends DataState {}

class DataWaiting extends DataState {}
