import 'package:flutter/material.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/connectivity-check.service.dart';
import 'package:provider/provider.dart';

/// Snackbar that is used to inform the user the state of the phone connection
class ConnectivityStatusSnackbar extends SnackBar {
  /// This snackbar will appear if the phone is connected to WiFi
  ConnectivityStatusSnackbar.wifi(
    this.context, {
    Key? key,
  }) : super(
          key: key,
          content: const Text('Estás conectado a través de Wifi.'),
          action: SnackBarAction(
              label: 'No mostrar',
              onPressed: () {
                final provider = Provider.of<ConnectivityCheckService>(context,
                    listen: false);
                provider.neverShowAgain = true;
              }),
        );

  /// This snackbar will appear if the phone is connected to Mobile
  ConnectivityStatusSnackbar.mobile(
    this.context, {
    Key? key,
  }) : super(
          key: key,
          content: const Text('Estás conectado con datos móviles.'),
          action: SnackBarAction(
              label: 'No mostrar',
              onPressed: () {
                final provider = Provider.of<ConnectivityCheckService>(context,
                    listen: false);
                provider.neverShowAgain = true;
              }),
        );

  /// This snackbar will appear if the phone is not connected
  ConnectivityStatusSnackbar.none(this.context, {Key? key})
      : super(
          key: key,
          content: const Text('Estás sin conexión a internet.'),
          action: SnackBarAction(
              label: 'No mostrar',
              onPressed: () {
                final provider = Provider.of<ConnectivityCheckService>(context,
                    listen: false);
                provider.neverShowAgain = true;
              }),
        );
  final BuildContext context;
}
