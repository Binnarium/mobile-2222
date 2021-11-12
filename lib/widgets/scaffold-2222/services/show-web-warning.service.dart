import 'package:flutter/foundation.dart';

class ShowWebWarningService {
  /// show web warning
  bool _webWarning = kIsWeb;

  bool get showWebWarning {
    return _webWarning;
  }

  /// dismiss guides, and store the preference in the storage
  Future<void> dismiss() async {
    _webWarning = false;
  }
}
