import 'package:lab_movil_2222/models/asset.dto.dart';

class PointsExplanationModel {
  PointsExplanationModel.fromMap(Map<String, dynamic> data)
      : explanation = data['explanation'] as String? ?? '',
        audio = data['audio']?['url'] == null
            ? null
            : AudioDto.fromMap(data['audio'] as Map<String, dynamic>);

  final String explanation;
  final AudioDto? audio;
}
