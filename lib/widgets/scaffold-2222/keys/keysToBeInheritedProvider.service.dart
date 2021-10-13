import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeysToBeInheritedProvider {
  final GlobalKey _leftArrowIconKey = GlobalKey();
  // final GlobalKey _boatIconKey = GlobalKey();
  // final GlobalKey _profileIconKey = GlobalKey();
  // final GlobalKey _infoIconKey = GlobalKey();
  // final GlobalKey _chatIconKey = GlobalKey();
  // final GlobalKey _rightArrowIconKey = GlobalKey();
  bool? _showUserGuide = true;

  SharedPreferences? _sharedPreferences;

  Future<void> displayGuide() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _showUserGuide = _sharedPreferences?.getBool('displayGuide');
    if (showUserGuide == null) {
      _sharedPreferences?.setBool('displayGuide', true);
      _showUserGuide = true;
    } else {
      _sharedPreferences?.setBool('displayGuide', false);
      _showUserGuide = false;
    }
  }

  bool? get showUserGuide {
    return _showUserGuide;
  }

  set showUserGuide(bool? value) {
    _showUserGuide = value;
  }

  GlobalKey get leftArrowIconKey {
    return _leftArrowIconKey;
  }

  // GlobalKey get boatIconKey {
  //   return _boatIconKey;
  // }

  // GlobalKey get profileIconKey {
  //   return _profileIconKey;
  // }

  // GlobalKey get infoIconKey {
  //   return _infoIconKey;
  // }

  // GlobalKey get chatIconKey {
  //   return _chatIconKey;
  // }

  // GlobalKey get rightArrowIconKey {
  //   return _rightArrowIconKey;
  // }
  // const KeysToBeInherited({
  //   Key? key,
  //   required this.leftArrowIconKey,
  //   required this.boatIconKey,
  //   required this.profileIconKey,
  //   required this.infoIconKey,
  //   required this.chatIconKey,
  //   required this.rightArrowIconKey,
  //   required Widget child,
  // }) : super(key: key, child: child);

  // final GlobalKey leftArrowIconKey;
  // final GlobalKey boatIconKey;
  // final GlobalKey profileIconKey;
  // final GlobalKey infoIconKey;
  // final GlobalKey chatIconKey;
  // final GlobalKey rightArrowIconKey;

  // static KeysToBeInherited of(BuildContext context) {
  //   return context.dependOnInheritedWidgetOfExactType<KeysToBeInherited>()!;
  // }

  // @override
  // bool updateShouldNotify(covariant InheritedWidget oldWidget) {
  //   return true;
  // }
}
