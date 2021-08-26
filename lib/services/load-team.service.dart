import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';

class LoadTeamService extends ILoadInformationService<TeamDto> {
  @override
  Future<TeamDto> load() async {
    final snap = await FirebaseFirestore.instance
        .collection('application')
        .doc('team')
        .get();

    if (!snap.exists) new ErrorDescription('Document team does not exists');

    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;

    final result = TeamDto.fromMap(payload);
    return result;
  }
}
