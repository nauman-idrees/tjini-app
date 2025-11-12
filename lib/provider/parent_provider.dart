import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/enum.dart';

class ParentProvider extends ChangeNotifier {
  ParentAction? _selectedAction;
  MainParentAction? _selectedMainAction;

  ParentAction? get selectedAction => _selectedAction;
  MainParentAction? get selectedMainAction => _selectedMainAction;

  bool isSelected(ParentAction action) {
    return _selectedAction == action;
  }

  void toggleSelection(ParentAction action) {
    if (_selectedAction == action) {
      _selectedAction = null;
    } else {
      _selectedAction = action;
    }
    notifyListeners();
  }

  bool isMainSelected(MainParentAction action) {
    return _selectedMainAction == action;
  }

  void toggleMainSelection(MainParentAction action) {
    if (_selectedMainAction == action) {
      _selectedMainAction = null;
    } else {
      _selectedMainAction = action;
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedAction = null;
    _selectedMainAction = null;
    notifyListeners();
  }
}
