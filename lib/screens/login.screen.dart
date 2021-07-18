import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/cities.screen.dart';
import 'package:lab_movil_2222/screens/teamSheet.screen.dart';
import 'package:lab_movil_2222/shared/models/Login.model.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///safeArea para dispositivos con pantalla notch
    return SafeArea(
      child: Scaffold(
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
          FutureBuilder(
            future: _readLoginContent(),
            builder: (BuildContext context, AsyncSnapshot<LoginDto> loginInfo) {
              if (loginInfo.hasError) {
                return Text(loginInfo.error.toString());
              }

              if (loginInfo.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                      ColorsApp.backgroundRed,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  ///logo de 2222
                  _logo(size),
                  SizedBox(height: size.height * 0.05),

                  ///texto inicial
                  Text(
                    'LabMóvil 2222'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(fontSizeFactor: 1.3),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.05),
                  _descriptionText(context, loginInfo.data!.pageTitle),
                  _video(loginInfo.data!.welcomeVideo["url"],
                      ColorsApp.backgroundRed),
                  _profundityText(context, loginInfo.data!.profundityText),
                  SizedBox(height: size.height * 0.05),
                  _sheetButton(context),
                  SizedBox(height: size.height * 0.05),
                ],
              );
            },
          ),

          /// formulario (falta aplicar backend)
          _loginForm(context),
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

  ///Párrafo de descripción
  _descriptionText(BuildContext context, String description) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        description,
        style:
            Theme.of(context).textTheme.subtitle2?.apply(fontSizeFactor: 1.2),
        textAlign: TextAlign.center,
      ),
    );
  }

  _profundityText(BuildContext context, String depthText) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        depthText,
        style:
            Theme.of(context).textTheme.subtitle2?.apply(fontSizeFactor: 1.2),
        textAlign: TextAlign.justify,
      ),
    );
  }

  _sheetButton(BuildContext context) {
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
          Navigator.of(context).pushReplacementNamed(TeamScreen.route);
        },
        child: Text(
          'Ficha de Equipo',
          style: korolevFont.headline6?.apply(),
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

  ///Formulario de login
  _loginForm(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Comienza tu aventura',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(fontSizeFactor: 1.3),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          _userField(context),
          SizedBox(
            height: 10,
          ),
          _passwordField(context),
          SizedBox(
            height: 15,
          ),
          _loginButton(context),
          _registerText(context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  TextButton _registerText(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('texto de registro presionado');
      },
      style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.red)),
      child: RichText(
        text: TextSpan(
          text: '¿No tienes cuenta? Regístrate ',
          style:
              Theme.of(context).textTheme.headline6?.apply(fontSizeFactor: 0.7),
          children: [
            TextSpan(
              text: 'aquí',
              style: Theme.of(context).textTheme.headline6?.apply(
                  decoration: TextDecoration.underline, fontSizeFactor: 0.7),
            )
          ],
        ),
      ),
    );
  }

  ///campo de usuario
  _userField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        cursorColor: Colors.black54,
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.apply(color: Colors.black54, fontSizeFactor: 0.8),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'usuario',
          hintStyle: Theme.of(context)
              .textTheme
              .headline5
              ?.apply(color: Colors.black54, fontSizeFactor: 0.8),
        ),
      ),
    );
  }

  ///campo de contraseña
  _passwordField(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        cursorColor: Colors.black54,
        style: Theme.of(context).textTheme.headline5?.apply(
              color: Colors.black54,
              fontSizeFactor: 0.8,
            ),
        textAlign: TextAlign.center,
        obscureText: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'password',
          hintStyle: Theme.of(context)
              .textTheme
              .headline5
              ?.apply(color: Colors.black54, fontSizeFactor: 0.8),
        ),
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
          Navigator.of(context).pushReplacementNamed(CitiesScreen.route);
        },
        child: Text(
          'Ingresar',
          style: korolevFont.headline6?.apply(),
        ),
      ),
    );
  }

  Future<LoginDto> _readLoginContent() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc('welcome')
        .get();
    if (!snap.exists) new ErrorDescription('Document welcome does not exists');
    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;

    final result = LoginDto.fromJson(payload);
    return result;
  }
}
