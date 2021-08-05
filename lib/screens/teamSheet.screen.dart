import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/models/Login.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class TeamScreen extends StatefulWidget {
  static const String route = '/team';

  @override
  _TeamScreenState createState() => _TeamScreenState();

  LoginDto? loginPayload;
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    super.initState();

    ILoadInformationService<LoginDto> loader = LoadLoginInformationService();
    loader
        .load()
        .then((value) => this.setState(() => this.widget.loginPayload = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundRed,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(size, context),
          ],
        ),
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size, BuildContext context) {
    ///sizing the container to the mobile
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),

      ///Listview of the whole screen
      child: ListView(
        children: [
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
            SizedBox(
              height: 20,
            ),
            
            SizedBox(
              height: 20,
            ),
            _teamSheet(context, this.widget.loginPayload!.teamText, size),
            SizedBox(
              height: 10,
            ),
          ],
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

  _teamSheet(BuildContext context, String teamText, Size size) {
    return Container(
      
      child: MarkdownBody(
        
        data: teamText,
        styleSheet: MarkdownStyleSheet(
          p: korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
          h2Align: WrapAlignment.center,
          
          h2: korolevFont.headline4,   
          h3Align: WrapAlignment.center,
          h3: korolevFont.headline6,       
          orderedListAlign: WrapAlignment.center,
          listBullet:  korolevFont.bodyText2?.apply(fontSizeFactor: 1.1),
          
        ),
      )
       
    );
  }
}
