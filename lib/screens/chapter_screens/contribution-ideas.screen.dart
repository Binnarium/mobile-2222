import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/player-contributions.dto.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/services/load-contributions-screen.dart';
import 'package:lab_movil_2222/services/upload-contribution.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ContributionIdeasScreen extends StatefulWidget {
  static const String route = '/contribution_idea';

  final CityDto city;
  final String? option;
  final LoadContributionService contributionLoader;
  ContributionIdeasScreen({
    Key? key,
    required CityDto city,
    String? option,
  })  : this.city = city,
        this.option = option,
        this.contributionLoader = LoadContributionService(cityRef: city.name),
        super(key: key);

  @override
  _ContributionIdeaScreenState createState() => _ContributionIdeaScreenState();
}

class _ContributionIdeaScreenState extends State<ContributionIdeasScreen> {
  List<Contribution> playerContributions = [];
  final contributionText = TextEditingController();
  StreamSubscription? userService;

  String? userUID;

  @override
  void initState() {
    super.initState();

    this.userService = UserService.instance.user$().listen((event) {
      userUID = event!.uid;
    });

    this
        .widget
        .contributionLoader
        .loadContributions(this.widget.city.name)
        .then((value) => this.setState(() => this.playerContributions = value));
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
              contributionContent: 'EXPLICACIÓN DE LAS CONTRIBUCIONES',
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

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: _contributionsBody(size),
          ),
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

    UploadContributionToFirebaseService.writePlayerContribution(
        userUID, cityRef, option, contributionText);
  }

  _contributionsBody(Size size) {
    final double sidePadding = size.width * 0.08;

    ///main container
    return Column(
      children: [
        if (this.playerContributions == null)
          Center(child: AppLoading())
        else ...[
          for (Contribution content in playerContributions)
            Padding(
              padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 40),
              child: _bodyContribution(size, content),
            )
        ],
      ],
    );
  }

  Widget _bodyContribution(Size size, Contribution contribution) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'Autor: ${contribution.player}',
              style: textTheme.headline6,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              'Contribución: ${contribution.textContent}',
              style: textTheme.bodyText1,
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 5,
              ),
              child: Text(
                'Me gusta',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors2222.black),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
