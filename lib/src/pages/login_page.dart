import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          _loginBody(size),
        ],
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

  _loginBody(Size size) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _logo(size),
          SizedBox(height: size.height * 0.05),
          Text(
            'LOREM IPSUM VIAJE',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Korolev',
                fontWeight: FontWeight.w500,
                fontSize: 29),
          ),
          SizedBox(height: size.height * 0.05),
          _descriptionText(),
          SizedBox(height: size.height * 0.05),
          _video(),
          SizedBox(height: size.height * 0.05),
          _loginForm(),
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

  _descriptionText() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas',
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Korolev',
            fontWeight: FontWeight.w500,
            fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  _video() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: FadeInImage(
        placeholder: AssetImage('assets/gifs/giphy.gif'),
        image: NetworkImage(
            "http://altsolutions.es/wp-content/uploads/2017/02/alt-solutions-subida-de-videos-en-youtube.jpg"),
      ),
    );
  }

  _loginForm() {
    return Container();
  }
}
