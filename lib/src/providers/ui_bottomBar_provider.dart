import 'package:flutter/material.dart';

class UIBottomBarProvider extends ChangeNotifier {
  int _selectedMenuOption = 0;

  int get selectedMenuOption => this._selectedMenuOption;

  set selectedMenuOption(int index) {
    this._selectedMenuOption = index;
    notifyListeners();
  }
}
