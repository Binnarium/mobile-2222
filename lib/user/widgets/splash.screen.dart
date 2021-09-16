import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/shared/widgets/background-video.widget.dart';
import 'package:lab_movil_2222/start-video/widgets/start-video.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/services/user.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  static const String route = '/splash';

  /// splash video controller
  final VideoPlayerController _controller =
      VideoPlayerController.asset('assets/videos/splash-video.mp4');

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
  Future<void> navigateNextPage(BuildContext context) async {
    /// authenticate user and redirect to correct screen
    final UserService _userService =
        Provider.of<UserService>(context, listen: false);
    final bool isSignIn = await _userService.isSignIn$.first;

    Navigator.pushReplacementNamed(
      context,
      isSignIn ? HomeScreen.route : StartVideoScreen.route,
    );
  }
}
