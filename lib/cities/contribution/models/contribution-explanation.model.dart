import 'package:lab_movil_2222/models/asset.dto.dart';

class ContributionExplanationModel {
  final String explanation;
  final String manifestUrl;
  final VideoDto video;

  ContributionExplanationModel.fromMap(Map<String, dynamic> data)
      : this.explanation = data['explanation'],
        this.manifestUrl = data['manifestUrl'],
        this.video = VideoDto.fromMap(data['video']);
}
