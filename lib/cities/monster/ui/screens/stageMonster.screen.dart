import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/asset.dto.dart';
import 'package:lab_movil_2222/cities/monster/model/monster.model.dart';
import 'package:lab_movil_2222/cities/monster/services/load-monster.service.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class StageMonsterScreen extends StatefulWidget {
  const StageMonsterScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const String route = '/monster';
  final CityModel city;

  @override
  _StageMonsterScreenState createState() => _StageMonsterScreenState();
}

class _StageMonsterScreenState extends State<StageMonsterScreen> {
  MonsterModel? _monsterModel;
  StreamSubscription? _loadMonsterSub;
  @override
  void initState() {
    super.initState();

    final LoadMonsterService loadMonsterService =
        Provider.of<LoadMonsterService>(context, listen: false);

    _loadMonsterSub = loadMonsterService.load$(widget.city).listen(
      (monsterModel) {
        if (mounted) {
          setState(() {
            _monsterModel = monsterModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadMonsterSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
      city: widget.city,
      backgrounds: const [BackgroundDecorationStyle.topRight],
      route: StageMonsterScreen.route,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LogosHeader(
            showAppLogo: false,
            showStageLogoCity: widget.city,
          ),

          /// content
          if (_monsterModel == null)
            const Center(
              child: AppLoading(),
            )
          else
            MonsterImage(image: _monsterModel!.illustration)
        ],
      ),
    );
  }
}

class MonsterImage extends StatelessWidget {
  const MonsterImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  final ImageDto image;

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
            placeholder:
                const AssetImage('assets/loaders/monster-placeholder.gif'),
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
