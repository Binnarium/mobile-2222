import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';

class LoadLoginInformationService extends ILoadInformationService<WelcomeDto> {
  @override
  Future<WelcomeDto> load() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc('welcome')
        .get();

    if (!snap.exists) new ErrorDescription('Document welcome does not exists');

    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;

    final result = WelcomeDto.fromMap(payload);
    return result;
  }
}
