import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/player/ui/widgets/gamification-item.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

class CurrentPlayerWorkshopAwards extends StatefulWidget {
  const CurrentPlayerWorkshopAwards({Key? key}) : super(key: key);

  @override
  State<CurrentPlayerWorkshopAwards> createState() =>
      _CurrentPlayerWorkshopAwardsState();
}

class _CurrentPlayerWorkshopAwardsState
    extends State<CurrentPlayerWorkshopAwards> {
  CurrentPlayerService get _currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  PlayerModel? currentPlayer;
  StreamSubscription? _currentPlayerSub;

  @override
  void initState() {
    _currentPlayerSub =
        _currentPlayerService.player$.listen((event) => currentPlayer = event);
  }

  @override
  void dispose() {
    _currentPlayerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// medals obtained
    return ObtainedMedalsCardWidget(
      numberOfMedals: currentPlayer?.workshopAwards.length ?? 0,
      image: const MedalImage.marathon(),
      label: 'Taller de\nIdeación Ágil',
      numberColor: Colors2222.black,
    );
  }
}
