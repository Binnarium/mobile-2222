import 'package:flutter/material.dart';
import 'package:lab_movil_2222/points-explanation/models/points-explanation.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown-card.widget.dart';

class ApproveText extends StatefulWidget {
  const ApproveText({
    Key? key,
    required this.pointsExplanation,
  }) : super(key: key);

  final PointsExplanationModel? pointsExplanation;
  @override
  _ApproveTextState createState() => _ApproveTextState();
}

class _ApproveTextState extends State<ApproveText> {
  @override
  Widget build(BuildContext context) {
    return widget.pointsExplanation == null
        ? const AppLoading()
        : Column(
            children: [
              MarkdownCard(
                content: widget.pointsExplanation!.explanation,
              ),
            ],
          );
  }
}
