import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project-awards/models/marathon-medal.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

const double MEDALS_LIMIT = 1;

class MedalsService {
  MedalsService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  /// load assigned medals
  Stream<List<MarathonMedalModel>> get marathonAwards$ =>
      _currentPlayerService.player$
          .switchMap<List<QueryDocumentSnapshot>>(
            (user) => user == null
                ? Stream.value([])
                : _getMarathonAwardsCollectionRef(user.uid)
                    .orderBy('awardedToUid')
                    .snapshots()
                    .map((snap) => snap.docs),
          )
          .map((docs) => docs
              .map((d) =>
                  MarathonMedalModel.fromMap(d.data()! as Map<String, dynamic>))
              .toList())
          .shareReplay();

  Stream<bool> get canAssignMarathonAwards$ => marathonAwards$
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
        final bool canSendAward = await canAssignMarathonAwards$.first;
        if (!canSendAward) {
          return false;
        }

        final MarathonMedalModel assignedMedal =
            MarathonMedalModel(awardedToUid: teammateUid);

        final WriteBatch batch = _fFirestore.batch();

        final CollectionReference currentPlayerAwards =
            _getMarathonAwardsCollectionRef(currentUser.uid);

        batch.set(currentPlayerAwards.doc(), assignedMedal.toMap());

        /// commit changes
        await batch.commit();
        return true;
      },
    );
  }

  CollectionReference _getMarathonAwardsCollectionRef(String uid) =>
      _fFirestore.collection('players').doc(uid).collection('marathon-awards');
}
