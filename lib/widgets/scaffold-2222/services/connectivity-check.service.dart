import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCheckService {
  ConnectivityResult connectionType = ConnectivityResult.none;

  StreamSubscription<ConnectivityResult> checkConnectionType$() {
    return Connectivity().onConnectivityChanged.listen((newConnection) {
      /// if there is no connection this will appear
      if (newConnection == ConnectivityResult.none) {
        connectionType = ConnectivityResult.none;
        print('Connection Type: None');

        /// if the phone reaches wifi connection
      } else if (newConnection == ConnectivityResult.wifi) {
        connectionType = ConnectivityResult.wifi;
        print('Connection Type: wifi');

        /// shows the mobile connection
      } else if (newConnection == ConnectivityResult.mobile) {
        connectionType = ConnectivityResult.mobile;
        print('Connection Type: mobile');
      }
    });
  }
}
