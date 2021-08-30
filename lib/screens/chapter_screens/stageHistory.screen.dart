import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city-history.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-city-history.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class StageHistoryScreen extends StatefulWidget {
  static const String route = '/history';
  final CityDto city;

  final LoadCityHistoryService historyLoader;

  StageHistoryScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.historyLoader = LoadCityHistoryService(city: city),
        super(key: key);

  @override
  _StageHistoryScreenState createState() => _StageHistoryScreenState();
}

class _StageHistoryScreenState extends State<StageHistoryScreen> {
  CityHistoryDto? historyDto;

  @override
  void initState() {
    super.initState();

    this
        .widget
        .historyLoader
        .load()
        .then((value) => this.setState(() => this.historyDto = value));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double bodyContainerHeight = size.height * 0.75;

    double spacedBodyContainers = bodyContainerHeight * 0.04;
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [
        BackgroundDecorationStyle.bottomLeft,
        BackgroundDecorationStyle.path
      ],
      route: StageHistoryScreen.route,
      body: ListView(
        children: <Widget>[
          LogosHeader(
            showStageLogoCity: this.widget.city,
          ),
          SizedBox(height: spacedBodyContainers),
          // _imageOne(size),
          _contentsBody(size),
          SizedBox(height: spacedBodyContainers),
        ],
      ),
    );
  }

  Widget _titleHistory(Size size, TitleHistoryDto history) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      child: Text(
        history.title,
        style: textTheme.headline6,
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _textHistory(Size size, TextHistoryDto history) {
    return Markdown2222(data: history.text);
  }

  Widget _buildHistoryImage(Size size, ImageHistoryDto history) {
    return Image(
      image: history.image == null
          ? getAppLogo(AppImage.cityLogo)
          : NetworkImage(history.image!.url),
      width: min(size.width * 0.4, 300),
      filterQuality: FilterQuality.high,
      fit: BoxFit.contain,
    );
  }

  _contentsBody(Size size) {
    final double sidePadding = size.width * 0.08;

    ///main container
    return Column(
      children: [
        if (this.historyDto == null)
          Center(child: AppLoading())
        else ...[
          for (HistoryContentDto content in this.historyDto!.content)
            if (content is TitleHistoryDto)
              Padding(
                padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 40),
                child: _titleHistory(size, content),
              )
            else if (content is ImageHistoryDto)
              Padding(
                padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 32),
                child: Row(
                  children: [
                    _buildHistoryImage(size, content),
                  ],
                ),
              )
            else if (content is TextHistoryDto)
              Padding(
                padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
                child: _textHistory(size, content),
              ),
        ],
      ],
    );
  }
}
