import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/player-contributions.dto.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/services/load-contributions-screen.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class ContributionScreen extends StatefulWidget {
  static const String route = '/contribution';

  final CityDto city;
  final LoadContributionService contributionLoader;
  ContributionScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.contributionLoader = LoadContributionService(cityRef: city.name),
        super(key: key);

  @override
  _ContributionScreenState createState() => _ContributionScreenState();
}

class _ContributionScreenState extends State<ContributionScreen> {
  List<Contribution> playerContributions = [];

  late List<CityDto> chapters;

  @override
  void initState() {
    super.initState();
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));

    this
        .widget
        .contributionLoader
        .loadContributions(this.widget.city.name)
        .then((value) => this.setState(() => this.playerContributions = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
        city: this.widget.city,
        backgrounds: [
          BackgroundDecorationStyle.bottomRight,
          BackgroundDecorationStyle.path
        ],
        route: ContributionScreen.route,
        body: _projectSheet(context, size, this.widget.city.color));
  }

  _projectSheet(BuildContext context, Size size, Color color) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 50),
        children: [
          Text(
            "CONTRIBUCIONES DE ${this.widget.city.name}".toUpperCase(),
            style: textTheme.headline4!.apply(fontWeightDelta: 2),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          _contentsBody(size),
        ]);
  }

  _contentsBody(Size size) {
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
              onPressed: (){

              },
            ),
            
          )
        ],
      ),
    );
  }
}
