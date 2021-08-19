import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/screens/team.screen.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = '/welcome';

  final ILoadInformationService<WelcomeDto> loader =
      LoadLoginInformationService();

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  WelcomeDto? loginPayload;

  @override
  void initState() {
    super.initState();

    this
        .widget
        .loader
        .load()
        .then((value) => this.setState(() => this.loginPayload = value));
  }


  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///safeArea para dispositivos con pantalla notch
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: ColorsApp.backgroundRed,
        ),

        ///Stack para apilar el background y luego el cuerpo de la pantalla
        body: Stack(
          children: [
            ///Container del color rojo
            CustomBackground(
              backgroundColor: ColorsApp.backgroundRed,
            ),

            ///contiene todo el cuerpo de la pantalla, se envía el size y el context
            ///para poder controlar varios tamaños de dispositivos y controlar
            ///la fuente
            _loginBody(size, context),
          ],
        ),
      ),
    );
  }

  ///Cuerpo de la pantalla
  _loginBody(Size size, BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 64),
      children: [
        /// app logo
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Center(
            child: AppLogo(
              kind: AppImage.defaultAppLogo,
              width: min(350, size.width * 0.6),
            ),
          ),
        ),

        /// App Title
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Text(
            'Lab Móvil 2222'.toUpperCase(),
            style: korolevFont.headline6!.apply(fontSizeFactor: 1.3),
            textAlign: TextAlign.center,
          ),
        ),

        /// loading animation
        if (this.loginPayload == null)
          Center(
            child: AppLoading(),
          )

        /// data is available
        /// logo de 2222
        else ...[
          /// principal text
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              this.loginPayload!.pageTitle,
              style: korolevFont.subtitle2?.apply(fontSizeFactor: 1.2),
              textAlign: TextAlign.center,
            ),
          ),

          /// video container
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: VideoPlayer(
              video: this.loginPayload!.welcomeVideo,
            ),
          ),

          /// profundity text
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Markdown2222(
              data: this.loginPayload!.profundityText,
            ),
          ),

          /// team button
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: TextButton(
              onPressed: () => Navigator.pushNamed(context, TeamScreen.route),
              child: Text('Equipo 2222'),
            ),
          ),

          /// profundity text
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: WorkloadMarkdown(
              workload: this.loginPayload!.workloadText,
            ),
          ),
        ],
      ],
    );
  }

  Container _logo(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      child: AppLogo(kind: AppImage.defaultAppLogo),
      // padding: EdgeInsets.only(
      //   top: size.height * 0.05,
      // ),
    );
  }

  _workloadText(BuildContext context, String workloadText, Size size) {
    return Container(
      width: double.infinity,
      // margin: EdgeInsets.symmetric(horizontal: 40),
      padding: EdgeInsets.symmetric(vertical: size.width * 0.1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7.0) //
            ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 0.7), //(x,y)
            blurRadius: 1.0,
          ),
        ],
      ),
      // child: MarkdownBody(
      //   data: workloadText,
      //   styleSheet: MarkdownStyleSheet(
      //     h2: korolevFont.headline6,
      //     listBullet: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
      //   ),
      // )
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Text(
              "Carga horaria estimada para cada docente por ciudad:",
              style: korolevFont.headline5?.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "10 horas",
            style: korolevFont.headline6?.apply(
              fontSizeFactor: 0.9,
              color: ColorsApp.backgroundRed,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              "Se trata de 4 horas para el consumo asíncrono de contenidos y 6 horas para el tiempo de producción y gamifiación",
              style: korolevFont.headline5?.apply(
                fontSizeFactor: 0.6,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Text(
              "Tiempo total del viaje 2222",
              style: korolevFont.headline5?.copyWith(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "120 horas",
            style: korolevFont.headline6?.apply(
              fontSizeFactor: 0.9,
              color: ColorsApp.backgroundRed,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              "para una duración máxima de 45 días",
              style: korolevFont.headline5?.apply(
                fontSizeFactor: 0.6,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "A disfrutar...",
            style: korolevFont.headline6?.apply(
              fontSizeFactor: 0.9,
              color: ColorsApp.backgroundRed,
            ),
          ),
        ],
      ),
    );
  }

  ///Párrafo de descripción
  _descriptionText(BuildContext context, String description, Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Text(
        description,
        style: korolevFont.subtitle2?.apply(fontSizeFactor: 1.2),
        textAlign: TextAlign.center,
      ),
    );
  }

  _profundityText(BuildContext context, String depthText, Size size) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32),
        child: MarkdownBody(
          data: depthText,
          styleSheet: MarkdownStyleSheet(
            p: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
            h2: korolevFont.headline6,
            listBullet: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
          ),
        ));
  }

  _sheetButton(BuildContext context, Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TeamScreen.route);
        },
        style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.red)),
        child: Text(
          'Equipo 2222',
          style: korolevFont.headline5?.apply(
              decoration: TextDecoration.underline, fontSizeFactor: 0.7),
        ),
      ),
    );
  }
}
