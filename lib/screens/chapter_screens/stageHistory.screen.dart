import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city-history.dto.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-city-history.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class StageHistoryScreen extends StatefulWidget {
  const StageHistoryScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/history';
  final CityModel city;

  @override
  _StageHistoryScreenState createState() => _StageHistoryScreenState();
}

class _StageHistoryScreenState extends State<StageHistoryScreen> {
  CityHistoryDto? historyDto;
  StreamSubscription? _loadHistorySub;

  @override
  void initState() {
    super.initState();

    final LoadCityHistoryService loadHistoryService =
        Provider.of<LoadCityHistoryService>(context, listen: false);

    _loadHistorySub = loadHistoryService.load$(widget.city).listen(
      (cityHistoryDto) {
        if (mounted) {
          setState(() {
            historyDto = cityHistoryDto;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadHistorySub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double bodyContainerHeight = size.height * 0.75;

    final double spacedBodyContainers = bodyContainerHeight * 0.04;
    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [
        BackgroundDecorationStyle.bottomLeft,
        BackgroundDecorationStyle.path
      ],
      route: StageHistoryScreen.route,
      body: ListView(
        children: <Widget>[
          LogosHeader(
            showStageLogoCity: widget.city,
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
    return SizedBox(
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

  Column _contentsBody(Size size) {
    final double sidePadding = size.width * 0.08;

    ///main container
    return Column(
      children: [
        if (historyDto == null)
          const Center(child: AppLoading())
        else ...[
          for (HistoryContentDto content in historyDto!.content)
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
