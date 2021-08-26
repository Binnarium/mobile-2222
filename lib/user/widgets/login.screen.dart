import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/screens/team.screen.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/widgets/register.screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  final ILoadInformationService<WelcomeDto> loader =
      LoadLoginInformationService();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  WelcomeDto? loginPayload;
  String? _email = 'player0@mail.com';
  String? _password = '123456';

  StreamSubscription? signInSub;

  @override
  void initState() {
    super.initState();

    this
        .widget
        .loader
        .load()
        .then((value) => this.setState(() => this.loginPayload = value));
  }

  @override
  void deactivate() {
    this.signInSub?.cancel();
    super.deactivate();
  }

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
              backgroundColor: Colors2222.red,
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
            style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
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
              style: textTheme.subtitle2?.apply(fontSizeFactor: 1.2),
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
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, TeamScreen.route),
                child: Text(
                  'Equipo 2222',
                  style: textTheme.headline5?.apply(
                      decoration: TextDecoration.underline,
                      fontSizeFactor: 0.7),
                ),
              ),
            ),
          ),

          /// profundity text
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: WorkloadMarkdown(
              workload: this.loginPayload!.workloadText,
            ),
          ),

          /// formulario (falta aplicar backend)
          _loginForm(context),
        ],
      ],
    );
  }

  ///Formulario de login
  _loginForm(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      child: Column(
        children: [
          Text(
            'Comienza tu aventura',
            style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
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
    final TextTheme textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, RegisterScreen.route),
      style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.red)),
      child: RichText(
        text: TextSpan(
          text: '¿No tienes cuenta? Regístrate ',
          style: textTheme.headline6?.apply(fontSizeFactor: 0.7),
          children: [
            TextSpan(
              text: 'aquí',
              style: textTheme.headline6?.apply(
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
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        initialValue: _email,
        onChanged: (value) {
          _email = value;
        },
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
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        initialValue: _password,
        onChanged: (value) {
          _password = value;
        },
        cursorColor: Colors.black54,
        style: textTheme.headline5?.apply(
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
    final TextTheme textTheme = Theme.of(context).textTheme;
    double buttonWidth = MediaQuery.of(context).size.width;
    return Container(
      width: buttonWidth,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors2222.backgroundBottomBar,
          elevation: 5,
        ),
        onPressed: () => this.signInSub = UserService.instance
            .signIn$(this._email!, this._password!)
            .listen((success) {
          if (success)
            Navigator.of(context).pushReplacementNamed(HomeScreen.route);
          else
            print(success);
        }),
        child: Text(
          'Ingresar',
          style: textTheme.headline6?.apply(),
        ),
      ),
    );
  }
}
