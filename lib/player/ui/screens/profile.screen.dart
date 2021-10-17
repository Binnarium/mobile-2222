import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/authentication/sign-out/sign-out-button.dart';
import 'package:lab_movil_2222/player/gamification-explanation/uid/gamification-text-explanation.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/player/ui/widgets/avatar-image.widget.dart';
import 'package:lab_movil_2222/player/ui/widgets/changeAvatarButton.widget.dart';
import 'package:lab_movil_2222/player/ui/widgets/player-course-status.dart';
import 'package:lab_movil_2222/player/ui/widgets/player-gamification.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamSubscription? _loadPlayerSub;

  /// current signed in player information
  PlayerModel? player;

  CurrentPlayerService get _currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    /// load player data
    _loadPlayerSub = _currentPlayerService.player$.listen((player) {
      setState(() {
        this.player = player;
      });
    });
  }

  @override
  void dispose() {
    _loadPlayerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sideSpacing = MediaQuery.of(context).size.width * 0.08;

    return Scaffold2222.navigation(
      activePage: Lab2222NavigationBarPages.profile,
      body: BackgroundDecoration(
        backgroundDecorationsStyles: const [
          BackgroundDecorationStyle.path,
          BackgroundDecorationStyle.topLeft
        ],

        /// page content
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: sideSpacing, vertical: 64),
          children: [
            if (player == null)
              const Center(child: AppLoading())
            else ...[
              /// title
              ProfileScreenTitle(context: context),

              const SizedBox(height: 32),

              /// player profile
              Row(
                children: [
                  /// player icon
                  SizedBox(
                    height: 80,
                    child: Stack(children: [
                      AvatarImage(image: player?.avatarImage),
                      Positioned(
                        bottom: -6,
                        right: -14,

                        /// implements the widget to change the avatar
                        /// logic is implemented on the button
                        child: ChangeAvatarButton(
                          player: player!,
                        ),
                      ),
                    ]),
                  ),

                  /// spacing between picture and information
                  const SizedBox(width: 10),

                  /// page content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// player name
                        Text(
                          player!.displayName,
                          style: Theme.of(context).textTheme.headline6,
                        ),

                        /// spacing
                        const SizedBox(height: 4),

                        /// email
                        Text(
                          player!.email,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 64),

              /// widget that contains a list of the player's gammification
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: PlayerGamification(
                  player: player!,
                ),
              ),

              GamificationTextExplanation(),
              const SizedBox(height: 25),
              PlayerCourseStatus(
                status: player!.courseStatus,
              ),
            ],

            /// spacer
            const SizedBox(height: 25),

            /// bottom to close current session
            /// always to be displayed even if player profile is never loaded
            const LogOutButton(),
          ],
        ),
      ),
    );
  }
}

class ProfileScreenTitle extends Text {
  ProfileScreenTitle({
    Key? key,
    required BuildContext context,
  }) : super(
          'Mi viaje al día'.toUpperCase(),
          key: key,
          style: Theme.of(context).textTheme.headline3,
          textAlign: TextAlign.center,
        );
}
