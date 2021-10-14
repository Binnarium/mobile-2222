import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// KeysToBeInheritedProvider
class ShowUserGuideService {
  /// track if service has loaded information
  bool _loadedConfiguration = false;

  /// current state of the show guide
  bool _displayGuide = true;

  /// Function to make configuration load when the application
  /// is first initialized
  ///
  /// Make sure this service is loaded before using it, otherwise
  /// an error will be throw
  ///
  /// If any error occurs when loading  configuration, this service
  /// will continue with the  configuration enabled by default
  Future<void> load() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      /// by default the configuration will be set to true
      /// if any configuration is found, set it to true
      _displayGuide = preferences.getBool('displayGuide') ?? true;
    } catch (e) {
      debugPrint(e.toString());
      _displayGuide = false;
    } finally {
      /// complete loading state
      _loadedConfiguration = true;
    }
  }

  bool get displayGuide {
    /// make sure configuration was loaded
    assert(
      _loadedConfiguration,
      'Configuration was not loaded, load configuration using [ShowUserGuideService.load()] at the start ofg your application',
    );

    return _displayGuide;
  }

  /// dismiss guides, and store the preference in the storage
  Future<void> dismissGuide() async {
    try {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      await preferences.setBool('displayGuide', true);
    } finally {
      _displayGuide = false;
    }
  }
}
