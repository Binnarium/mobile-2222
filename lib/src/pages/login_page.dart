import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _background(),
            _loginBody(size, context),
          ],
        ),
      ),
    );
  }

  _background() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xffD52027),
    );
  }

  _loginBody(Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _logo(size),
          SizedBox(height: size.height * 0.05),
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
        
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.05,
      ),
    );
  }

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
