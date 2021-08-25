import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/start-video/widgets/start-video.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/splash';

  final String videoPath = "assets/videos/splash-video.mp4";

  @override
  Widget build(BuildContext context) {
    //tamaño de la pantalla
    return Scaffold(
      backgroundColor: Colors2222.red,
      body: BackgroundVideo(
        controller: VideoPlayerController.asset(this.videoPath),
        lopping: false,
        onComplete: () => this.navigateNextPage(context),
        onPressed: () => this.navigateNextPage(context),
      ),
    );
  }

  /// redirect user to navigate to next page, to sign in page, or to home page if already signed in
  void navigateNextPage(BuildContext context) {
    /// authenticate user and redirect to correct screen
    final bool isSignIn = UserService.instance.isSignIn();
    if (isSignIn)
      Navigator.pushReplacementNamed(context, HomeScreen.route);
    else
      Navigator.pushReplacementNamed(context, StartVideoScreen.route);
  }
}
