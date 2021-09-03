import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lab_movil_2222/models/player-contributions.dto.dart';

class LoadContributionService {
  final String cityRef;
  const LoadContributionService({
    Key? key,
    required String cityRef,
  }) : this.cityRef = cityRef;

  Future<List<Contribution>> loadContributions(String cityRef) async {
    final payload = await FirebaseFirestore.instance
        .collection('contributions')
        .doc(cityRef)
        .get();

    
    if (payload.exists) {
    //  
     List<dynamic> data = payload.data()!.values.first;
     List<Contribution> contributions = [];
     data.forEach((element) {
       
      //  print('informaciom: $element');
       contributions.add(Contribution.fromMap(element));
     });
     contributions.forEach((element) {       
       print('Elemento: ${element.cityName}');
       
     });
    
     return contributions;
    } else {
      return [];
    }
  }
}
