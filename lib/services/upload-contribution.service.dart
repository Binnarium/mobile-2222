import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lab_movil_2222/models/player-contributions.dto.dart';

import 'package:lab_movil_2222/services/load-player-information.service.dart';

class UploadContributionToFirebaseService {
 

 

  static void writeContribution(String userUID, String cityRef, String option) {
    Map<String, dynamic> contribution = {
      'cityRef': cityRef,
      'type': option,
      
      'contributed': true,
      'obtainedDate': Timestamp.now()
    };

    FirebaseFirestore.instance.collection('players').doc(userUID).update(
      {
        'contributions': FieldValue.arrayUnion([contribution])
      },
    );
  }

  static void writePlayerContribution(
      String userUID, String cityRef, String option, String textContent) async {
    Map<String, String> contributionText = {'option': option, 'textContent': textContent};
    LoadPlayerInformationService playerLoader = LoadPlayerInformationService();
    List<PlayerContribution> contributions = await playerLoader.loadContributions(userUID);
    bool existingContribution = false;
    contributions.forEach((element) {
      
      if (element.cityName == cityRef ) {
        existingContribution = true;
      }
    });
    if (existingContribution) {
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userUID)
          .collection('contribution')
          .doc(cityRef)
          .update(
        {
          'contributions': FieldValue.arrayUnion([contributionText])
        },
      );
    } else {
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userUID)
          .collection('contribution')
          .doc(cityRef)
          .set({
        'contributed': true,
        'cityName': cityRef,
        'contributions': [contributionText]
      });
    }
  }
}
