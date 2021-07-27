import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:lab_movil_2222/screens/teamSheet.screen.dart';
import 'package:lab_movil_2222/services/i-load-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/models/Login.model.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();

  LoginDto? loginPayload;
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    ILoadInformationService<LoginDto> loader = LoadLoginInformationService();
    loader
        .load()
        .then((value) => this.setState(() => this.widget.loginPayload = value));
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
    return SingleChildScrollView(
      child: Column(
        children: [
          // if (this.widget.error) {
          //   Text(loginInfo.error.toString());
          // }

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
            _logo(size),
            SizedBox(height: size.height * 0.05),

            ///texto inicial
            Text(
              'LabMóvil 2222'.toUpperCase(),
              style: korolevFont.headline6!.apply(fontSizeFactor: 1.3),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.05),
            _descriptionText(
                context, this.widget.loginPayload!.pageTitle, size),
            _video(this.widget.loginPayload!.welcomeVideo["url"],
                ColorsApp.backgroundRed),
            _profundityText(
                context, this.widget.loginPayload!.profundityText, size),
            SizedBox(height: size.height * 0.01),
            _sheetButton(context, size),
            SizedBox(height: size.height * 0.01),
            _workloadText(context,this.widget.loginPayload!.workloadText,size),
            SizedBox(height: size.height * 0.05),

            /// formulario (falta aplicar backend)
          ],
        ],
      ),
    );
  }

  Container _logo(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/logo_background2.png',
        ),
        filterQuality: FilterQuality.high,
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.05,
      ),
    );
  }
  _workloadText(BuildContext context, String workloadText, Size size) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 40),
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, vertical: size.width * 0.1),
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
        child: MarkdownBody(
          data: workloadText,
          styleSheet: MarkdownStyleSheet(
            h2: korolevFont.headline6,
            listBullet: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
          ),
        ));
  }

  ///Párrafo de descripción
  _descriptionText(BuildContext context, String description, Size size) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
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
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
     
      child : MarkdownBody(
        data: depthText,
        styleSheet: MarkdownStyleSheet(
          p: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
          h2: korolevFont.headline6,          
          listBullet:  korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
          
        ),
       
        
      )
    );
  }

  _sheetButton(BuildContext context, Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TeamScreen.route);
        },
        style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.red)),
        child: Text(
          'Equipo 2222',
          style: korolevFont.headline6?.apply(
              decoration: TextDecoration.underline, fontSizeFactor: 0.7),
        ),
      ),
    );
  }

  ///Vídeo que actualmente está como NetworkImage
  _video(String url, Color color) {
    return VideoPlayerSegment(
      videoUrl: url,
      color: color,
    );
  }
}
