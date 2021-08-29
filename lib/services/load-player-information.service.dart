import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/models/player-contributions.dto.dart';
import 'package:lab_movil_2222/models/player-projects.dto.dart';
import 'package:lab_movil_2222/models/player.dto.dart';

class LoadPlayerInformationService {
  Future<List<PlayerProject>> loadProjects(String userUID) async {
    final payload = await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .collection('project')
        .get();
    List<PlayerProject> projects =
        payload.docs.map((e) => PlayerProject.fromMap(e.data(), e.id)).toList();
    projects.forEach((element) {
      print("USER PROJECTS: ${element.cityName}");
    });
    return projects;
  }

  Future<List<PlayerContribution>> loadContributions(String userUID) async {
    final payload = await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .collection('contribution')
        .get();
    if (payload.docs.isNotEmpty) {
      List<PlayerContribution> contributions = payload.docs
          .map((e) => PlayerContribution.fromMap(e.data(), e.id))
          .toList();
      contributions.forEach((element) {
        print("USER CONTRIBUTIONS: ${element.cityName}");
      });
      return contributions;
    }else{
      return [];
    }

    
  }

  Future<dynamic> loadInformation(String userUID) async {
    final payload = await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .get();

    if (!payload.exists)
      throw new ErrorDescription('Player information not found');
    return PlayerDto.fromMap(payload.data()!);
  }
}
