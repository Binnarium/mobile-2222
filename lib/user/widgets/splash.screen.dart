import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/start-video/widgets/start-video.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/services/user.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}       

class _SplashScreenState extends State<SplashScreen> {
  /// splash video controller
  final VideoPlayerController _controller =
      VideoPlayerController.asset('assets/videos/splash-video.mov');

  StreamSubscription? navigatingSub;

  IsUserSignInService get _userService =>
      Provider.of<IsUserSignInService>(context, listen: false);

  @override
  void dispose() {
    navigatingSub?.cancel();
    navigatingSub = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //tamaño de la pantalla
    return Scaffold2222.empty(
      backgroundColor: Colors2222.red,
      body: BackgroundVideo(
        controller: _controller,
        lopping: false,
        onComplete: () => navigateNextPage(context),
        onPressed: () => navigateNextPage(context),
      ),
    );
  }

  /// redirect user to navigate to next page, to sign in page, or to home page if already signed in
  void navigateNextPage(BuildContext context) {
    if (navigatingSub != null) {
      return;
    }

    /// authenticate user and redirect to correct screen
    navigatingSub = _userService.isSignIn$.listen(
      (isSignIn) async {
        await Navigator.pushReplacementNamed(
          context,
          isSignIn ? HomeScreen.route : StartVideoScreen.route,
        );
        navigatingSub?.cancel();
        navigatingSub = null;
      },
    );
  }
}
