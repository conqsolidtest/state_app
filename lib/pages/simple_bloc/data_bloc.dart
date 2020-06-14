import 'dart:async';

class DataBloc {
  DataBloc() {
    _eventController.stream.listen(_mapEventToStream);
  }
  double _dataValue;
  final StreamController<double> _dataController =
      StreamController<double>.broadcast();

  Stream<double> get dataStream => _dataController.stream.asBroadcastStream();

  final StreamController<DataOperation> _eventController =
      StreamController<DataOperation>.broadcast();
  StreamSink<DataOperation> get eventSink => _eventController.sink;

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
  SetData({this.newDataValue});
  double newDataValue;
}
