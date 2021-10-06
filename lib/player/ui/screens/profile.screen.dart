import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/player/ui/widgets/changeAvatarButton.widget.dart';
import 'package:lab_movil_2222/player/ui/widgets/player-gammification.widget.dart';
import 'package:lab_movil_2222/points-explanation/models/points-explanation.model.dart';
import 'package:lab_movil_2222/points-explanation/services/get-points-explanation.service.dart';
import 'package:lab_movil_2222/points-explanation/uid/widgets/points-explanation.widget.dart';
import 'package:lab_movil_2222/services/load-players-scoreboard.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/days_left_widget.dart';
import 'package:lab_movil_2222/user/widgets/widgets/sign-out-button.dart';
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
  StreamSubscription? _explanationSub;
  StreamSubscription? _scoreboardSub;
  PlayerModel? player;
  List<PlayerModel>? players;
  PointsExplanationModel? _pointsExplanation;

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
   

    final GetPointsExplanationService loadExplanationService =
        Provider.of<GetPointsExplanationService>(context, listen: false);

    _explanationSub = loadExplanationService.explanation$().listen(
      (pointsExplanationModel) {
        if (mounted) {
          setState(() {
            _pointsExplanation = pointsExplanationModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadPlayerSub?.cancel();
    _explanationSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sideSpacing = MediaQuery.of(context).size.width * 0.08;

    return Scaffold2222.navigation(
      activePage: Lab2222NavigationBarPages.profile,
      body: BackgroundDecoration(
        // ignore: prefer_const_literals_to_create_immutables
        backgroundDecorationsStyles: [
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
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Text(
                  'Mi viaje al día'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),

              /// player profile
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 64,
                ),
                child: Row(
                  children: [
                    /// player icon
                    Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          onTap: () async {
                            return showAvatarImage(context);
                          },
                          child: SizedBox(
                            height: 80,
                            child: Stack(children: [
                              if (player?.avatarImage.url == '')
                                const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/backgrounds/decorations/elipse_profile.png'),
                                  maxRadius: 40,
                                )
                              else
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    player!.avatarImage.url,
                                  ),
                                  maxRadius: 40,
                                ),
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
                          )),
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
              ),

              /// widget that contains a list of the player's gammification
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: PlayerGamification(
                  player: player!,
                  pointsExplanation: _pointsExplanation,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ApproveText(
                  pointsExplanation: _pointsExplanation,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: DaysLeftWidget(),
              ),
            ],
            const LogOutButton(),
          ],
        ),
      ),
    );
  }

  Future<void> showAvatarImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
              child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (player?.avatarImage.url == '')
                  const Image(
                    image: AssetImage(
                        'assets/backgrounds/decorations/elipse_profile.png'),
                  )
                else
                  Image.network(
                    player!.avatarImage.url,
                  ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
        });
  }
}
