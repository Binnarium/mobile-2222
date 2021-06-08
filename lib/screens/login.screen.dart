import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class LoginScreen extends StatelessWidget {
  static const String route = '/login';
  //página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //safeArea para dispositivos con pantalla notch
    return SafeArea(
      child: Scaffold(
        //Stack para apilar el background y luego el cuerpo de la pantalla
        body: Stack(
          children: [
            //Container del color rojo
            CustomBackground(
              backgroundColor: ColorsApp.backgroundRed,
            ),
            //contiene todo el cuerpo de la pantalla, se envía el size y el context
            //para poder controlar varios tamaños de dispositivos y controlar
            //la fuente
            _loginBody(size, context),
          ],
        ),
      ),
    );
  }

  //Cuerpo de la pantalla
  _loginBody(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //logo de 2222
          _logo(size),
          SizedBox(height: size.height * 0.05),
          //texto inicial
          Text(
            'LOREM IPSUM VIAJE',
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.05),
          _descriptionText(context),
          SizedBox(height: size.height * 0.05),
          _video(),
          SizedBox(height: size.height * 0.1),
          //formulario (falta aplicar backend)
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

  //Párrafo de descripción
  _descriptionText(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas',
        style:
            Theme.of(context).textTheme.subtitle2?.apply(fontSizeFactor: 1.2),
        textAlign: TextAlign.center,
      ),
    );
  }

  //Vídeo que actualmente está como NetworkImage
  _video() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: FadeInImage(
        placeholder: AssetImage('assets/gifs/giphy.gif'),
        image: NetworkImage(
            "http://altsolutions.es/wp-content/uploads/2017/02/alt-solutions-subida-de-videos-en-youtube.jpg"),
      ),
    );
  }

  //Formulario de login
  _loginForm(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Comienza tu aventura',
            style: Theme.of(context).textTheme.headline5,
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
            height: 5,
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(Colors.red)),
            child: RichText(
              text: TextSpan(
                text: '¿No tienes cuenta? Regístrate ',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.apply(fontSizeFactor: 0.8),
                children: [
                  TextSpan(
                    text: 'aquí',
                    style: Theme.of(context).textTheme.bodyText1?.apply(
                        decoration: TextDecoration.underline,
                        fontSizeFactor: 0.8),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  //campo de usuario
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

  //campo de contraseña
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
}
