import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/player-contributions.dto.dart';
import 'package:lab_movil_2222/services/load-contributions-screen.dart';

class UploadContributionToFirebaseService {
  static void writePlayerContribution(
      String userUID, String cityRef, String option, String textContent) async {
    Map<String, dynamic> contributionText = {
      'player': userUID,
      'option': option,
      'textContent': textContent,
      'cityName': cityRef,
      'contributed': true
    };

    LoadContributionService contributionLoader =
        LoadContributionService(cityRef: cityRef);
    List<Contribution> contributions =
        await contributionLoader.loadContributions(cityRef);
    bool existingContribution = false;
    bool existingContributionPlayer = false;
    contributions.forEach((element) {
      if (element.cityName == cityRef) {
        existingContribution = true;
      }
      if(element.player == userUID){
        existingContributionPlayer=true;
      }
    });

    if (existingContribution && !existingContributionPlayer) {
      print('entra en exist ${cityRef}');
      await FirebaseFirestore.instance
          .collection('contributions')
          .doc(cityRef)
          .update({
        'contributions': FieldValue.arrayUnion([contributionText])
      });
    } else if(!existingContribution){
      print('entra en create ${cityRef}');
      await FirebaseFirestore.instance
          .collection('contributions')
          .doc(cityRef)
          .set({
        'contributions': FieldValue.arrayUnion([contributionText])
      });
    }
  }
}
