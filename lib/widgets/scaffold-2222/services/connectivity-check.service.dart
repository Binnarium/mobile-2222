import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/connectivity-snackbar.widget.dart';

class ConnectivityCheckService {
  bool neverShowAgain = false;

  StreamSubscription<ConnectivityResult> checkConnectionType$(
      BuildContext context) {
    return Connectivity().onConnectivityChanged.listen((newConnection) {
      print('NEVER SHOW AGAIN?: $neverShowAgain');

      /// if there is no connection this will appear
      if (newConnection == ConnectivityResult.none && neverShowAgain == false) {
        /// shows the no connection snackbar
        ScaffoldMessenger.of(context)
            .showSnackBar(ConnectivityStatusSnackbar.none(context));

        /// if the phone reaches connection, it will enter in this block
      } else if (newConnection == ConnectivityResult.wifi &&
          neverShowAgain == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ConnectivityStatusSnackbar.wifi(context));

        /// shows the mobile  connection snackbar
      } else if (newConnection == ConnectivityResult.mobile &&
          neverShowAgain == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(ConnectivityStatusSnackbar.mobile(context));
      }
    });
  }
}
