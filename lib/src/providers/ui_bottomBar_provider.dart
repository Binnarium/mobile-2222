import 'package:flutter/material.dart';

class UIBottomBarProvider extends ChangeNotifier {
  int _selectedMenuOption = 1;
  bool _isInitialPage = false;
  bool _isFinalPage = false;

  int get selectedMenuOption => this._selectedMenuOption;

  set selectedMenuOption(int index) {
    this._selectedMenuOption = index;
    notifyListeners();
  }

  bool get isInitialPage => this._isInitialPage;

  set isInitialPage(bool value) {
    this._isInitialPage = value;
    notifyListeners();
  }

  bool get isFinalPage => this._isFinalPage;

  set isFinalPage(bool value) {
    this._isFinalPage = value;
    notifyListeners();
  }
}
