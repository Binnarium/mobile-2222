import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/services/upload-contribution.service.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ContributionIdeasScreen extends StatefulWidget {
  static const String route = '/contribution_idea';

  final CityDto city;
  final String? option;

  ContributionIdeasScreen({
    Key? key,
    required CityDto city,
    String? option,
  })  : this.city = city,
        this.option = option,
        super(key: key);

  @override
  _ContributionIdeaScreenState createState() => _ContributionIdeaScreenState();
}

class _ContributionIdeaScreenState extends State<ContributionIdeasScreen> {
  final contributionText = TextEditingController();
  StreamSubscription? userService;

  String? userUID;

  String? fileName;
  PlayerModel? player;
  @override
  void initState() {
    super.initState();

    this.userService = UserService.instance.user$().listen((event) {
      userUID = event!.uid;
      LoadPlayerInformationService playerLoader =
          LoadPlayerInformationService();
      playerLoader.loadInformation(event.uid).then((value) => this.setState(() {
            this.player = value;
          }));
      playerLoader.loadContributions(event.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    

  

    return Scaffold(
        backgroundColor: this.widget.city.color,
        body: _contributionBody(context));
  }

  _contributionBody(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// back button to return previous page
          BackButton(color: Colors2222.white),

          /// page content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: ContributionContenMarkdown(
              contributionContent:
                  '${this.widget.option} DE LA CIUDAD'.toUpperCase(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: ContributionContenMarkdown(
              contributionContent:
                  'EXPLICACIÓN DE LAS CONTRIBUCIONES',
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: TextField(
              controller: contributionText,
              onSubmitted: (_) {
                uploadContribution(userUID!, this.widget.city.name,
                        this.widget.option!, contributionText.text)
                    .then((value) {
                  setState(() {});
                });
              },
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              minLines: 1,
              maxLines: 10,
              cursorColor: Colors2222.black,
              style: TextStyle(color: Colors2222.black),
              decoration: InputDecoration(
                  fillColor: Colors2222.white,
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
        onPressed: () {
          uploadContribution(userUID!, this.widget.city.name,
                  this.widget.option!, contributionText.text)
              .then((value) {
            setState(() {});
          });
        },
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

  Future uploadContribution(String userUID, String cityRef, String option,
      String contributionText) async {
    /// to write the project in the users contribution collection
    
    
        
    UploadContributionToFirebaseService.writePlayerContribution(userUID, cityRef, option, contributionText);
  }
}
