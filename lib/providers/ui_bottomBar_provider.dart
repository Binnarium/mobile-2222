import 'package:flutter/material.dart';

class UIBottomBarProvider extends ChangeNotifier {
  int _selectedMenuOption = 0;
  bool _isInitialPage = false;
  bool _isFinalPage = false;

  int get selectedMenuOption => _selectedMenuOption;

  set selectedMenuOption(int index) {
    _selectedMenuOption = index;
    notifyListeners();
  }

  bool get isInitialPage => _isInitialPage;

  set isInitialPage(bool value) {
    _isInitialPage = value;
    notifyListeners();
  }

  bool get isFinalPage => _isFinalPage;

  set isFinalPage(bool value) {
    _isFinalPage = value;
    notifyListeners();
  }
}
