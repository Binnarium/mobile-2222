import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/player.dto.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/days_left_widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/medals-list-item_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String route = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamSubscription? signoutSub;
  StreamSubscription? userService;
  String? userUID;
  PlayerDto? player;

  @override
  void initState() {
    super.initState();
    this.userService = UserService.instance.userUID$().listen((event) {
      userUID = event!.uid;
      LoadPlayerInformationService playerLoader =
          LoadPlayerInformationService();
      playerLoader.loadInformation(event.uid).then((value) => this.setState(() {
            this.player = value;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            /// deprecated ignored due to Scaffold2222 needs city parameter
            // ignore: deprecated_member_use_from_same_package
            ChapterBackgroundWidget(
              backgroundColor: Colors2222.red,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(size, context),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.page3,
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size, BuildContext context) {
    double bodyContainerHeight = size.height * 0.33;
    double bodyMarginLeft = size.width * 0.10;
    if (size.width > 500) {
      bodyContainerHeight = size.height * 0.99;
    }
    
     List<Medal> medalsTemp = player!.medals;

    /// sizing the container to the mobile
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 10),
      children: [
        // TODO: fix this screen
        // ChapterHeadWidget(
        //   phaseName: 'etapa 4',
        //   chapterName: 'aztlán',
        //   city:
        //       'assets/backgrounds/chapterImages/aztlan_chapter_img.png',
        // ),
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          child: Text(
            'Mi viaje al día'.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline4!
                .apply(fontWeightDelta: 2),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),

        Padding(
          padding: EdgeInsets.only(bottom: 32),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Image(
                image: AssetImage(
                    'assets/backgrounds/decorations/elipse_profile.png'),
                height: 80,
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Wrap(
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      direction: Axis.vertical,
                      children: [
                        Text((player != null) ? player!.name : 'cargando'),
                        SizedBox(
                          height: 3,
                        ),
                        Text((player != null) ? player!.email : 'cargando'),
                      ])),
            ],
          ),
        ),
        

        Padding(
            padding: EdgeInsets.only(
                left: bodyMarginLeft, right: bodyMarginLeft, bottom: 10),
            child: Text(
              'NIVELES COMPLETADOS',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.apply(fontSizeFactor: 0.80),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.center,
            )),

        Container(
            // decoration:
            //     BoxDecoration(border: Border.all(color: Colors.white)),
            margin:
                EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
            child: Text(
              '4',
              style: Theme.of(context).textTheme.headline4?.apply(),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.center,
            )),

        Padding(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white)
          // ),
          padding: EdgeInsets.only(
              left: bodyMarginLeft, right: bodyMarginLeft, bottom: 10),
          child: Text(
            'CONSUMO DE CONTENIDOS',
            style: Theme.of(context).textTheme.headline6,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white)
          // ),
          padding: EdgeInsets.only(
              left: bodyMarginLeft, right: bodyMarginLeft, bottom: 30),
          child: Text(
            '22%',
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
          padding: EdgeInsets.only(
              left: bodyMarginLeft, right: bodyMarginLeft, bottom: 10),
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
              left: bodyMarginLeft, right: bodyMarginLeft, bottom: 35),
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
                'Premios mínimos necesarios para aspirar a seguir en sharngri-la: 17',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 25),
          child: DaysLeftWidget(),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Wrap(
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.vertical,
              children: [
                for (var item in medalsTemp)
                  (item != null)
                      ? MedalsListItem(
                          cityRef: item.cityRef,
                        )
                      : Text('Cargando medallas'),
              ],
            )),
        _logoutButton(context),
        SizedBox(
          height: 32,
        ),
      ],
    );
  }
  

  _routeCurve() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/white_route_curve_background.png',
        ),
        color: Color.fromRGBO(255, 255, 255, 100).withOpacity(0.3),
      ),
    );
  }

  _logoutButton(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    double buttonWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: buttonWidth * 0.1),
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors2222.backgroundBottomBar,
          elevation: 5,
        ),
        onPressed: () =>
            this.signoutSub = UserService.instance.signOut$().listen((success) {
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
