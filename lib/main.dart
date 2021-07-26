import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/app-222.dart';

///    ___    ___    ___    ___
///   |__ \  |__ \  |__ \  |__ \
///      ) |    ) |    ) |    ) |
///     / /    / /    / /    / /
///    / /_   / /_   / /_   / /_
///   |____| |____| |____| |____|
///
///   ------------------------------------------------------------
///
///   Made with love at binnarium, in collaboration with UTPL and
///   Outliers Schools.
///
///   All right reserved Binnarium SAS.
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// TODO: configure name with production and development stages
  await Firebase.initializeApp();

  /// main entry point to build application
  runApp(App2222());
}
