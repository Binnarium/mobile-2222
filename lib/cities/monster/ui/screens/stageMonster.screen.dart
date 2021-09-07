import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/monster/model/monster.model.dart';
import 'package:lab_movil_2222/cities/monster/services/load-monster.service.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

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
  MonsterModel? _monsterModel;
  StreamSubscription? _loadMonsterSub;
  @override
  void initState() {
    super.initState();

    LoadMonsterService loadMonsterService =
        Provider.of<LoadMonsterService>(this.context, listen: false);

    this._loadMonsterSub = loadMonsterService.load$(this.widget.city).listen(
      (monsterModel) {
        if (this.mounted)
          this.setState(() {
            this._monsterModel = monsterModel;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadMonsterSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: StageMonsterScreen.route,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LogosHeader(
            showAppLogo: false,
            showStageLogoCity: this.widget.city,
          ),

          /// content
          this._monsterModel == null
              ? Center(
                  child: AppLoading(),
                )
              : MonsterImage(image: this._monsterModel!.illustration)
        ],
      ),
    );
  }
}

class MonsterImage extends StatelessWidget {
  final ImageDto image;
  const MonsterImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.08,
            vertical: constraints.maxHeight * 0.08,
          ),
          child: FadeInImage(
            placeholder: getAppLogo(AppImage.loadingLogo),
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
            image: NetworkImage(
              image.url,
            ),
          ),
        ),
      ),
    );
  }
}