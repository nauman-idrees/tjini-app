import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../core/enum.dart';
import '../ui/screens/establishment_profile_screen.dart';

class DispatcherProvider extends ChangeNotifier {
  DispatcherAction? _selectedAction;
  ParentStatus? _selectedStudentAction;

  DispatcherAction? get selectedAction => _selectedAction;
  ParentStatus? get selectedStudentAction => _selectedStudentAction;

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

  void toggleStudentSelection(ParentStatus action) {
    if (_selectedStudentAction == action) {
      _selectedStudentAction = null;
    } else {
      _selectedStudentAction = action;
    }
    notifyListeners();
  }

  void clearSelection() {
    _selectedAction = null;
    _selectedStudentAction = null;
    notifyListeners();
  }
}
