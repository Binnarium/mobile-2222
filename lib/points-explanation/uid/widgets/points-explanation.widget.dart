import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/points-explanation/models/points-explanation.model.dart';
import 'package:lab_movil_2222/points-explanation/services/get-points-explanation.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown-card.widget.dart';
import 'package:provider/provider.dart';

class ApproveText extends StatefulWidget {
  const ApproveText({
    Key? key,
  }) : super(key: key);

  @override
  _ApproveTextState createState() => _ApproveTextState();
}

class _ApproveTextState extends State<ApproveText> {
  StreamSubscription? _explanationSub;

  PointsExplanationModel? pointsExplanation;

  @override
  void initState() {
    super.initState();

    GetPointsExplanationService loadExplanationService =
        Provider.of<GetPointsExplanationService>(this.context, listen: false);

    this._explanationSub = loadExplanationService.explanation$().listen(
      (pointsExplanationModel) {
        if (this.mounted)
          this.setState(() {
            this.pointsExplanation = pointsExplanationModel;
          });
      },
    );
  }

  @override
  void dispose() {
    this._explanationSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return this.pointsExplanation == null
        ? AppLoading()
        : MarkdownCard(
            content: this.pointsExplanation!.explanation,
          );
  }
}
