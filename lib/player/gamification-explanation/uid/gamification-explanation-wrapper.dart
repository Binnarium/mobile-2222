import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/gamification-explanation/models/gamification-explanation.model.dart';
import 'package:lab_movil_2222/player/gamification-explanation/services/gamification-explanation.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:provider/provider.dart';

/// class to load points explanation and share ir to a builder
abstract class GamificationExplanationWrapper extends StatefulWidget {
  const GamificationExplanationWrapper({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(GamificationExplanationModel) builder;

  @override
  State<GamificationExplanationWrapper> createState() =>
      _GamificationExplanationWrapperState();
}

class _GamificationExplanationWrapperState
    extends State<GamificationExplanationWrapper> {
  StreamSubscription? _explanationSub;

  /// points explanation
  GamificationExplanationModel? _pointsExplanation;

  @override
  void initState() {
    super.initState();
    final GamificationExplanationService gamificationExplanationService =
        Provider.of<GamificationExplanationService>(context, listen: false);

    _explanationSub = gamificationExplanationService.explanation$().listen(
      (pointsExplanationModel) {
        if (mounted) {
          setState(() {
            _pointsExplanation = pointsExplanationModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _explanationSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _pointsExplanation == null
        ? const AppLoading()
        : widget.builder(_pointsExplanation!);
  }
}
