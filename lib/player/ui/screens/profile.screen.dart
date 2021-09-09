import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/player/services/update-avatar.service.dart';
import 'package:lab_movil_2222/player/widgets/user-gamification.widget.dart';
import 'package:lab_movil_2222/points-explanation/uid/widgets/points-explanation.widget.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/days_left_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';

  final UpdateAvatarService _updateAvatarService;

  ProfileScreen({
    Key? key,
  })  : this._updateAvatarService = UpdateAvatarService(),
        super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamSubscription? _signOutSub;
  StreamSubscription? _loadPlayerSub;
  StreamSubscription? _uploadFileSub;
  PlayerModel? player;
  ImageDto? avatarImage;

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
    avatarImage = this.player?.avatarImage;
    int numberProjects = this.player!.projectAwards.length;
    int numberClubhouses = this.player!.clubhouseAwards.length;
    int numberProactivity = numberProjects + numberClubhouses;
    // int numberContributions = this.player!.contributionsAwards.length;

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
                                child: ElevatedButton(
                                  onPressed: _changeAvatar,
                                  style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      primary: Colors.black,
                                      onPrimary: Colors.white,
                                      elevation: 0),
                                  child: Icon(Icons.photo_camera_rounded),
                                ),
                              ),
                            ]),
                          ),
                          onTap: () async {
                            return await changeAvatarDialog(context);
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

              /// player's gammification
              GammificationWidget(
                number: numberProactivity,
                kind: GammificationKind.proactivity,
              ),

              SizedBox(
                height: 32,
              ),
              Container(
                height: 1,
                color: Colors2222.white.withOpacity(0.5),
              ),
              SizedBox(
                height: 32,
              ),

              GammificationWidget(
                number: numberProjects,
                kind: GammificationKind.prizes,
                image: AssetImage('assets/gamification/2222_monedas.png'),
              ),
              SizedBox(
                height: 40,
              ),

              GammificationWidget(
                number: numberClubhouses,
                kind: GammificationKind.clubhouse,
                image: AssetImage(
                    'assets/gamification/2222_medalla-clubhouse.png'),
              ),
              SizedBox(
                height: 64,
              ),

              // Padding(
              //   padding: EdgeInsets.only(bottom: 10),
              //   child: Text(
              //     'Premios Obtenidos',
              //     style: Theme.of(context).textTheme.headline5,
              //     textAlign: TextAlign.center,
              //   ),
              // ),

              // for (AwardModel medal in this.player!.projectAwards)
              //   MedalsListItem(
              //     cityName: medal.cityId,
              //   ),

              // MedalsListItem(
              //   cityName: 'Quitu',
              // ),

              // /// project medals
              // if (this.player!.clubhouseAwards.length > 0) ...[
              //   Padding(
              //     padding: EdgeInsets.only(bottom: 10),
              //     child: Text(
              //       'Medallas clubhouse',
              //       style: Theme.of(context).textTheme.headline5,
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              //   for (AwardModel medal in this.player!.clubhouseAwards)
              //     MedalsListItem(
              //       cityName: medal.cityId,
              //     ),
              // ],

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

  Future<void> changeAvatarDialog(BuildContext context) {
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

  /// method to change the avatarImage
  void _changeAvatar() async {
    if (this._uploadFileSub != null) return;
    String oldUrl = this.player!.avatarImage.url;
    print('old image url');
    UploadImageService uploadImageService =
        Provider.of<UploadImageService>(context, listen: false);

    this._uploadFileSub = uploadImageService
        .upload$('players/${this.player!.uid}/assets')
        .switchMap((image) =>
            this.widget._updateAvatarService.updateAvatar$(image, oldUrl))
        .listen((sended) {
      if (sended) print('Imagen cambiada correctamente');
    }, onDone: () {
      this._uploadFileSub?.cancel();
      this._uploadFileSub = null;
    });
  }
}
