import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class StageMonsterScreen extends StatefulWidget {
  static const String route = '/monster';
  final CityDto city;

  const StageMonsterScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  _StageMonsterScreenState createState() => _StageMonsterScreenState();
}

class _StageMonsterScreenState extends State<StageMonsterScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print(size);
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: StageMonsterScreen.route,
      body: _backgroundDecoration(size),
    );
  }

  _backgroundDecoration(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ChapterHeadWidget(
          showAppLogo: false,
          showStageLogo: true,
          city: this.widget.city,
        ),
        Expanded(
          child: Center(
            child: _ghostImage(size),
          ),
        )
      ],
    );
  }

  _ghostImage(Size size) {
    return FutureBuilder(
      future: _readIlustrationURL(),
      builder: (BuildContext context, AsyncSnapshot<String> url) {
        if (url.hasError) {
          return Text(url.error.toString());
        }

        if (url.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
        }
        return Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height * 0.08,
              horizontal: size.width * 0.08,
            ),
            child: FadeInImage(
              placeholder: getAppLogo(AppImage.loadingLogo),
              fit: BoxFit.contain,
              width: size.width * 0.8,
              height: size.height * 0.7,
              image: NetworkImage(
                url.data.toString(),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> _readIlustrationURL() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.city.id)
        .collection('pages')
        .doc('monster')
        .get();

    if (!snap.exists)
      new ErrorDescription(' URL of Illustration does not exists');

    String url = snap.get('illustration')['url'].toString();

    return url;
  }
}
