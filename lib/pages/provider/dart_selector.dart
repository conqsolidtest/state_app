import 'package:flutter/foundation.dart';

class DartSelector with ChangeNotifier {
  DartSelector({double initialValue = 10.0}) {
    value = initialValue;
  }
  double value;
  double get dartValue => value;

  set dartValue(double v) {
    if (v != value) {
      value = v - v % 10;
      notifyListeners();
    }
  }
}
