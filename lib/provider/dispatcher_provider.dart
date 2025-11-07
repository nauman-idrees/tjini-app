import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/enum.dart';

class DispatcherProvider extends ChangeNotifier {
  DispatcherAction? _selectedAction;

  DispatcherAction? get selectedAction => _selectedAction;

  bool isSelected(DispatcherAction action) {
    return _selectedAction == action;
  }

  void toggleSelection(DispatcherAction action) {
    if (_selectedAction == action) {
      _selectedAction = null;
    } else {
      _selectedAction = action;
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedAction = null;
    notifyListeners();
  }
}
