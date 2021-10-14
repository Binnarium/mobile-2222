import 'package:shared_preferences/shared_preferences.dart';

// KeysToBeInheritedProvider
class ShowUserGuideService {
  bool? _showUserGuide = true;

  Future<void> displayGuide() async {
    final SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _showUserGuide = _sharedPreferences.getBool('displayGuide');
    if (_showUserGuide == null) {
      _sharedPreferences.setBool('displayGuide', true);
      _showUserGuide = true;
    } else {
      _sharedPreferences.setBool('displayGuide', false);
      _showUserGuide = false;
    }
  }

  bool? get showUserGuide {
    return _showUserGuide;
  }

  set showUserGuide(bool? value) {
    _showUserGuide = value;
  }
}
