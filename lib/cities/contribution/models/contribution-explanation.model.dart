import 'package:lab_movil_2222/models/asset.dto.dart';

class ContributionExplanationModel {
  ContributionExplanationModel.fromMap(Map<String, dynamic> data)
      : explanation = data['explanation'] as String,
        manifestUrl = data['manifestUrl'] as String,
        video = VideoDto.fromMap(
            data['video'] as Map<String, dynamic>? ?? <String, dynamic>{});

  final String explanation;
  final String manifestUrl;
  final VideoDto video;
}
