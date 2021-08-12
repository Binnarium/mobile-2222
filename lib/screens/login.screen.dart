import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/screens/team.screen.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  final ILoadInformationService<WelcomeDto> loader =
      LoadLoginInformationService();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  WelcomeDto? loginPayload;
  String? _email;
  String? _password;

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
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 64),
      children: [
        /// loading animation
        if (this.loginPayload == null)
          Center(
            child: AppLoading(),
          )

        /// data is available
        /// logo de 2222
        else ...[
          /// app logo
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Center(
              child: AppLogo(
                kind: AppImage.defaultAppLogo,
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
            child: VideoPlayerSegment(
              color: ColorsApp.backgroundRed,
              videoUrl: this.loginPayload!.welcomeVideo.url,
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

          /// formulario (falta aplicar backend)
          _loginForm(context),
        ],
      ],
    );
  }

  ///Formulario de login
  _loginForm(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Comienza tu aventura',
            style: korolevFont.headline6!.apply(fontSizeFactor: 1.3),
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
          style: korolevFont.headline6?.apply(fontSizeFactor: 0.7),
          children: [
            TextSpan(
              text: 'aquí',
              style: korolevFont.headline6?.apply(
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
      child: TextField(
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
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        onChanged: (value) {
          _password = value;
        },
        cursorColor: Colors.black54,
        style: korolevFont.headline5?.apply(
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorsApp.backgroundBottomBar,
          elevation: 5,
        ),

        ///Navigates to main screen
        onPressed: () {
          _login();
          
        },
        child: Text(
          'Ingresar',
          style: korolevFont.headline6?.apply(),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email!, password: _password!);
    } on FirebaseAuthException catch (e) {
      print("Error: $e");
    } catch (e) {
      print("Error: $e");
    }
  }
}
