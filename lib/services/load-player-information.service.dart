import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    if (payload.docs.isNotEmpty) {
      List<PlayerProject> projects = payload.docs
          .map((e) => PlayerProject.fromMap(e.data(), e.id))
          .toList();
      projects.forEach((element) {
        // print("USER PROJECTS: ${element.cityName}");
      });
      return projects;
    } else
      return [];
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

  

  Future<PlayerDto> loadInformation(String userUID) async {

    final payload = await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .get();

    if (!payload.exists)
      throw new ErrorDescription('Player information not found');
    return PlayerDto.fromMap(payload.data()!);
  }

  static void updateAvatar(String userUID, String filename, String path,
      String url, String oldImageURL) async {
    Map<String, dynamic> imageMap = {
      'width': 0,
      'height': 0,
      'name': filename,
      'path': path,
      'url': url,
    };
    if (oldImageURL != "") {
      await FirebaseStorage.instance.refFromURL(oldImageURL).delete();
      print('Succesfully deleted avatar from storage');
    }
    await FirebaseFirestore.instance.collection('players').doc(userUID).update(
      {'avatarImage': imageMap},
    );
  }
}