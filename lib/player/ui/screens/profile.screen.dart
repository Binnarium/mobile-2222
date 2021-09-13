import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/player/ui/widgets/changeAvatarButton.widget.dart';
import 'package:lab_movil_2222/player/ui/widgets/player-gammification.widget.dart';
import 'package:lab_movil_2222/points-explanation/uid/widgets/points-explanation.widget.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/days_left_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamSubscription? _signOutSub;
  StreamSubscription? _loadPlayerSub;
  PlayerModel? player;

  @override
  void initState() {
    super.initState();

    /// load player data
    this._loadPlayerSub =
        CurrentPlayerService.instance.player$.listen((player) {
      this.setState(() {
        this.player = player;
      });
    });
  }

  @override
  void dispose() {
    this._signOutSub?.cancel();
    this._loadPlayerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double sideSpacing = MediaQuery.of(context).size.width * 0.08;

    return Scaffold2222.navigation(
      activePage: Lab2222NavigationBarPages.profile,
      body: BackgroundDecoration(
        backgroundDecorationsStyles: [
          BackgroundDecorationStyle.path,
          BackgroundDecorationStyle.topLeft
        ],

        /// page content
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: sideSpacing, vertical: 64),
          children: [
            if (this.player == null)
              Center(child: AppLoading())
            else ...[
              /// title
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Text(
                  'Mi viaje al día'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),

              /// player profile
              Padding(
                padding: EdgeInsets.only(
                  bottom: 64,
                ),
                child: Row(
                  children: [
                    /// player icon
                    Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: 80,
                            child: Stack(children: [
                              (this.player?.avatarImage.url == "")
                                  ? CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/backgrounds/decorations/elipse_profile.png'),
                                      maxRadius: 40,
                                    )
                                  : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        this.player!.avatarImage.url,
                                      ),
                                      maxRadius: 40,
                                    ),
                              Positioned(
                                bottom: -6,
                                right: -14,

                                /// implements the widget to change the avatar
                                /// logic is implemented on the button
                                child: ChangeAvatarButton(
                                  player: this.player!,
                                ),
                              ),
                            ]),
                          ),
                          onTap: () async {
                            return await showAvatarImage(context);
                          }),
                    ),

                    /// spacing between picture and information
                    SizedBox(width: 10),

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
                          SizedBox(height: 4),

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
                child: PlayerGamification(player: this.player!),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: ApproveText(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: DaysLeftWidget(),
              ),
            ],
            _logoutButton(context),
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
              child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                (this.player?.avatarImage.url == "")
                    ? Image(
                        image: AssetImage(
                            'assets/backgrounds/decorations/elipse_profile.png'),
                      )
                    : Image.network(
                        this.player!.avatarImage.url,
                      ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
        });
  }

  ElevatedButton _logoutButton(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors2222.backgroundBottomBar,
        elevation: 5,
      ),
      onPressed: () =>
          this._signOutSub = UserService.instance.signOut$().listen((success) {
        if (success) {
          /// shows snackbar
          scaffold.showSnackBar(SnackBar(
            content: Text(
              "Cierre de sesión exitoso.",
              style: textTheme.bodyText1,
            ),
            backgroundColor: Colors2222.backgroundBottomBar,
            action: SnackBarAction(
                label: 'ENTENDIDO',
                textColor: Colors.blue.shade300,
                onPressed: scaffold.hideCurrentSnackBar),
          ));
          Navigator.of(context).pushReplacementNamed(LoginScreen.route);
        } else
          print(success);
      }),
      child: Text(
        'Cerrar sesión',
        style: textTheme.headline6?.apply(),
      ),
    );
  }
}
