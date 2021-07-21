import 'package:flutter/material.dart';
import 'package:lab_movil_2222/services/i-load-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/models/Login.model.dart';

import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class TeamScreen extends StatefulWidget {
  static const String route = '/team';

  @override
  _TeamScreenState createState() => _TeamScreenState();

  LoginDto? loginPayload;
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    super.initState();

    ILoadInformationService<LoginDto> loader = LoadLoginInformationService();
    loader
        .load()
        .then((value) => this.setState(() => this.widget.loginPayload = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundRed,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(size, context),
          ],
        ),
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size, BuildContext context) {
    double bodyMarginWidth = size.width * 0.03;

    double bodyMarginLeft = size.width * 0.10;

    ///sizing the container to the mobile
    return Container(
      margin: EdgeInsets.only(
        right: bodyMarginWidth,
      ),

      ///Listview of the whole screen
      child: ListView(
        children: [
          if (this.widget.loginPayload == null)
            Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  ColorsApp.backgroundRed,
                ),
              ),
            ),

          /// data is available
          /// logo de 2222
          if (this.widget.loginPayload != null) ...[
            SizedBox(
              height: 50,
            ),
            Container(
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.white)
                // ),
                margin: EdgeInsets.only(
                    left: bodyMarginLeft, right: bodyMarginLeft),
                child: Text(
                  'Equipo 2222'.toUpperCase(),
                  style: korolevFont.headline3?.apply(fontSizeFactor: 0.96),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 20,
            ),
            _teamSheet(context, this.widget.loginPayload!.teamText),
            SizedBox(
              height: 10,
            ),
            _loginButton(context),
          ],
        ],
      ),
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
        color: Color.fromRGBO(255, 255, 255, 100),
      ),
    );
  }

  _loginButton(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width;
    return Container(
      width: buttonWidth,
      margin: EdgeInsets.symmetric(horizontal: 40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorsApp.backgroundBottomBar,
          elevation: 5,
        ),

        ///Navigates to main screen
        onPressed: () {
          // Navigator.of(context).pushReplacementNamed(CitiesScreen.route);
          Navigator.of(context).pop();
        },
        child: Text(
          'Home Screen',
          style: korolevFont.headline6?.apply(),
        ),
      ),
    );
  }

  _teamSheet(BuildContext context, String teamText) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        teamText,
        style:
            Theme.of(context).textTheme.bodyText2?.apply(fontSizeFactor: 1.1),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
