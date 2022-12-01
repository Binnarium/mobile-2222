import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ListPlayerOfGroupService {
  /// constructor
  ListPlayerOfGroupService(BuildContext context)
      : _firestore = FirebaseFirestore.instance,
        _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false);

  /// params
  final FirebaseFirestore _firestore;
  final CurrentPlayerService _currentPlayerService;

  /// load teammates of the group payer is currently at
  Stream<List<PlayerModel>> get group$ =>
      _currentPlayerService.player$.switchMap((currentUser) {
        if (currentUser == null) {
          return Stream.value([]);
        }

        /// get collection of users
        /// from the players collections
        /// select players with the same group id as the [currentUser],
        /// and do not match with the same uid of the current user
        final Query groupQuery = _firestore
            .collection('players')
            .where('groupId', isEqualTo: currentUser.groupId)
            .where('uid', isNotEqualTo: currentUser.uid);

        return groupQuery
            .snapshots()

            /// obtain docs of payload
            .map(
              (snap) => snap.docs.map((doc) =>
                  doc.data() as Map<String, dynamic>? ?? <String, dynamic>{}),
            )

            /// map data to instances of group player
            .map(
              (docs) => docs.map((data) => PlayerModel.fromMap(data)).toList(),
            );
      });

  Stream<List<PlayerModel>> get marathonGroup$ =>
      _currentPlayerService.player$.switchMap((currentUser) {
        if (currentUser == null) {
          return Stream.value([]);
        }

        /// get collection of users
        /// from the players collections
        /// select players with the same group id as the [currentUser],
        /// and do not match with the same uid of the current user
        Query groupQuery = _firestore
            .collection('players')
            .where('marathonGroupId', isEqualTo: currentUser.marathonGroupId)
            .where('uid', isNotEqualTo: currentUser.uid);

        /// if member has a group, don't load them
        if (currentUser.groupId != null)
          groupQuery =
              groupQuery.where('groupId', isNotEqualTo: currentUser.groupId);

        return groupQuery
            .snapshots()

            /// obtain docs of payload
            .map(
              (snap) => snap.docs.map((doc) =>
                  doc.data() as Map<String, dynamic>? ?? <String, dynamic>{}),
            )

            /// map data to instances of group player
            .map(
              (docs) => docs.map((data) => PlayerModel.fromMap(data)).toList(),
            );
      });

  /// load teammates of the group payer is currently at
  Stream<List<PlayerModel>> get workshop$ =>
      _currentPlayerService.player$.switchMap((currentUser) {
        if (currentUser == null) {
          return Stream.value([]);
        }

        /// get collection of users
        /// from the players collections
        /// select players with the same group id as the [currentUser],
        /// and do not match with the same uid of the current user
        Query groupQuery = _firestore
            .collection('players')
            .where('playerType', isEqualTo: currentUser.playerType)
            .where('courseStatus',
                isEqualTo:
                    'COURSE#APPROVE_CONTINUE_NEXT_PHASE_HAS_CONTENT_ACCESS')
            .where('uid', isNotEqualTo: currentUser.uid);

        return groupQuery
            .snapshots()

            /// obtain docs of payload
            .map(
              (snap) => snap.docs.map((doc) =>
                  doc.data() as Map<String, dynamic>? ?? <String, dynamic>{}),
            )

            /// map data to instances of group player
            .map(
              (docs) => docs.map((data) => PlayerModel.fromMap(data)).toList(),
            );
      });
}
