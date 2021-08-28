import 'package:flutter/material.dart';

import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';


class ContributionIdeaScreen extends StatefulWidget {
  static const String route = '/contribution_idea';

  @override
  _ContributionIdeaScreenState createState() => _ContributionIdeaScreenState();
}

class _ContributionIdeaScreenState extends State<ContributionIdeaScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            /// Ignore deprecated cause Scaffold 2222 needs city as param
            // ignore: deprecated_member_use_from_same_package
            ChapterBackgroundWidget(
              backgroundColor: Colors2222.white,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(context),
          ],
        ),
      ),
    );
  }

  _resourcesContent(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// back button to return previous page
          BackButton(color: Colors.black),

          /// page content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: ContributionContenMarkdown(
              teamContent: 'IDEA SOBRE LA CIUDAD',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: Text(
               'EXPLICACIÓN ACERCA DE LA IDEA DE LA CIUDAD EN LA PLANIFICACIÓN DE CONTRIBUCIONES',
               style: TextStyle(color: Colors2222.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: TextField(
              minLines: 1,
              maxLines: 2,
              cursorColor: Colors2222.black,
              style: TextStyle(color: Colors2222.black),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 60),
                  fillColor: Colors2222.grey,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors2222.black))),
            ),
          ),
          _ideaButton(context),
        ],
      ),
    );
  }

  _routeCurve() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/white_route_curve_background.png',
        ),
        color: Colors.white.withOpacity(0.25),
      ),
    );
  }

  _ideaButton(BuildContext context) {
  double buttonWidth = MediaQuery.of(context).size.width;
  
  return Container(
    width: buttonWidth,
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 5,
      ),

      ///Navigates to main screen
      onPressed: () {},
      child: Text(
        'ENVIAR IDEA',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors2222.black),
      ),
    ),
  );
}

}
