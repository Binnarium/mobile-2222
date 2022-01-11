import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/workshop-medals/models/workshop-medal.model.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

const double MEDALS_LIMIT = 1;

class WorkshopMedalsService {
  WorkshopMedalsService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  /// load assigned medals
  Stream<List<WorkshopMedalModel>> get workshopAwards$ =>
      _currentPlayerService.player$
          .switchMap<List<QueryDocumentSnapshot>>(
            (user) => user == null
                ? Stream.value([])
                : _getWorkshopAwardsCollectionRef(user.uid)
                    .orderBy('awardedToUid')
                    .snapshots()
                    .map((snap) => snap.docs),
          )
          .map((docs) => docs
              .map((d) =>
                  WorkshopMedalModel.fromMap(d.data()! as Map<String, dynamic>))
              .toList())
          .shareReplay();

  Stream<bool> get canAssignWorkshopAwards$ => workshopAwards$
      .map((awards) => awards.length < MEDALS_LIMIT)
      .shareReplay();

  /// assign teammate award
  Stream<bool> assignMedal$({
    required String cityId,
    required String teammateUid,
  }) {
    return _currentPlayerService.player$.take(1).asyncMap<bool>(
      (currentUser) async {
        if (currentUser == null) {
          return false;
        }

        /// validate player can send medals
        final bool canSendAward = await canAssignWorkshopAwards$.first;
        if (!canSendAward) {
          return false;
        }

        final WorkshopMedalModel assignedMedal =
            WorkshopMedalModel(awardedToUid: teammateUid);

        final WriteBatch batch = _fFirestore.batch();

        final CollectionReference currentPlayerAwards =
            _getWorkshopAwardsCollectionRef(currentUser.uid);

        batch.set(currentPlayerAwards.doc(), assignedMedal.toMap());

        /// commit changes
        await batch.commit();
        return true;
      },
    );
  }

  CollectionReference _getWorkshopAwardsCollectionRef(String uid) =>
      _fFirestore.collection('players').doc(uid).collection('workshop-awards');
}
