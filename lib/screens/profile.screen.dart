import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/player.dto.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/days_left_widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/medals-list-item_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamSubscription? _signOutSub;
  StreamSubscription? _loadPlayerSub;
  PlayerDto? player;

  @override
  void initState() {
    super.initState();

    /// load player data
    this._loadPlayerSub = UserService.instance.player$().listen((player) {
      this.setState(() {
        this.player = player;
      });
    });
  }

  @override
  void deactivate() {
    this._signOutSub?.cancel();
    this._loadPlayerSub?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sideSpacing = size.width * 0.08;

    return Scaffold(
      backgroundColor: Colors2222.red,
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.page3,
      ),
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
                  style: Theme.of(context).textTheme.headline4,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                ),
              ),

              /// player profile
              Padding(
                padding: EdgeInsets.only(bottom: 64),
                child: Row(
                  children: [
                    /// player icon
                    Image(
                      image: AssetImage(
                          'assets/backgrounds/decorations/elipse_profile.png'),
                      height: 80,
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

              /// completed levels
              Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'NIVELES COMPLETADOS',
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  )),

              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Text(
                  '4',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'CONSUMO DE CONTENIDOS',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  '22%',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: sideSpacing, right: sideSpacing, bottom: 10),
                child: Text(
                  'PROXIMA ETAPA',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.apply(fontSizeFactor: 0.60),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: sideSpacing, right: sideSpacing, bottom: 35),
                child: Text(
                  'ATLÁNTIDA',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.apply(fontSizeFactor: 0.80, fontWeightDelta: 2),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: WorkloadMarkdown(
                  workload:
                      'Premios mínimos necesarios para aspirar a seguir en Sharngri-la: 17 puntos!',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: DaysLeftWidget(),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Medallas Obtenidas',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
              ),
              for (Medal medal in this.player!.medals)
                MedalsListItem(
                  cityName: medal.cityRef,
                ),
            ],
            _logoutButton(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton _logoutButton(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    double buttonWidth = MediaQuery.of(context).size.width;
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

// class LoadPlayerDialog extends StatefulWidget {
//   @override
//   LoadPlayerState createState() => LoadPlayerState();
// }

// class LoadPlayerState extends State<LoadPlayerDialog> {
//   StreamSubscription? userService;
//   String? userUID;
//   PlayerDto? player;

//   @override
//   void initState() {
//     super.initState();
//     this.userService = UserService.instance.userUID$().listen((event) {
//       userUID = event!.uid;
//       LoadPlayerInformationService playerLoader =
//           LoadPlayerInformationService();
//       playerLoader.loadInformation(event.uid).then((value) => this.setState(() {
//             this.player = value;
//           }));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.only(bottom: 15),
//         child: Wrap(
//             runAlignment: WrapAlignment.center,
//             crossAxisAlignment: WrapCrossAlignment.start,
//             direction: Axis.vertical,
//             children: [
//               Text((player != null) ? player!.name : 'cargando'),
//               SizedBox(
//                 height: 3,
//               ),
//               Text((player != null) ? player!.email : 'cargando'),
//             ]));
//   }

//   Padding loadMedals() {
//     final List<Medal> medalsTemp = player!.medals;
//     return Padding(
//         padding: const EdgeInsets.only(bottom: 15),
//         child: Wrap(
//           runAlignment: WrapAlignment.center,
//           crossAxisAlignment: WrapCrossAlignment.start,
//           direction: Axis.vertical,
//           children: [
//             for (var item in medalsTemp)
//               (player!.medals != null)
//                   ? MedalsListItem(
//                       cityRef: item.cityRef,
//                     )
//                   : Text('Cargando medallas'),
//           ],
//         ));
//   }
// }
