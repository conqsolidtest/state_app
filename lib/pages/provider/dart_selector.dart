import 'package:flutter/foundation.dart';

class DartSelector with ChangeNotifier {
  double value;
  DartSelector({initialValue = 10.0}) {
    this.value = initialValue;
  }
  get dartValue => value;

  set dartValue(double v) {
    if (v != value) {
      value = v - v % 10;
      notifyListeners();
    }
  }
}
