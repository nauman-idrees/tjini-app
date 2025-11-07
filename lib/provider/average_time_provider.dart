import 'package:flutter/foundation.dart';

class AverageTimeProvider extends ChangeNotifier {
  int _time = 10;

  int get time => _time;

  void increment() {
    _time += 5;
    notifyListeners();
  }

  void decrement() {
    if (_time > 0) {
      _time -= 5;
      notifyListeners();
    }
  }

  void reset() {
    _time = 10;
    notifyListeners();
  }
}
