class ConnectivityCheckService {
  bool _neverShowAgain = false;

  bool get neverShowAgain {
    return _neverShowAgain;
  }

  set neverShowAgain(bool value) {
    _neverShowAgain = value;
  }
}
