import 'dart:async';

class DataBloc {
  double _dataValue;
  final _dataController = StreamController<double>.broadcast();

  Stream<double> get dataStream => _dataController.stream.asBroadcastStream();

  final _eventController = StreamController<DataOperation>.broadcast();
  StreamSink<DataOperation> get eventSink => _eventController.sink;

  DataBloc() {
    _eventController.stream.listen(_mapEventToStream);
  }

  void _mapEventToStream(DataOperation operation) {
    if (operation is SetData) {
      _dataValue = operation.newDataValue;
    }

    _dataController.sink.add(_dataValue);
  }

  void dispatch(DataOperation operation) {
    eventSink.add(operation);
  }

  void dispose() {
    _dataController.close();
    _eventController.close();
  }
}

abstract class DataOperation {}

class SetData extends DataOperation {
  double newDataValue;

  SetData({this.newDataValue});
}
