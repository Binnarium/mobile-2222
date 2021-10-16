import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/gamification-explanation/models/gamification-explanation.model.dart';
import 'package:lab_movil_2222/player/gamification-explanation/uid/gamification-explanation-wrapper.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown-card.widget.dart';

/// aprobe explanation using a card to display its content
class GamificationTextExplanation extends GamificationExplanationWrapper {
  GamificationTextExplanation({
    Key? key,
  }) : super(
          key: key,
          builder: (GamificationExplanationModel explanation) => MarkdownCard(
            content: explanation.explanation,
          ),
        );
}
