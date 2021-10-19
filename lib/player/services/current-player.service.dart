import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:rxdart/rxdart.dart';

class CurrentPlayerService {
  CurrentPlayerService()
      : _firestore = FirebaseFirestore.instance,
        _auth = FirebaseAuth.instance;

  /// [internal] track if service has been loaded information
  bool _loadedConfiguration = false;

  /// services
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  /// cached information of player
  ///
  /// access sync value using the [currentPlayer] getter
  PlayerModel? _player;

  Future<void> load() async {
    _loadedConfiguration = true;
    player$.listen((player) {
      _player = player;
    });
  }

   Stream<PlayerModel?>? _playerSource$;

  /// get stream value of player
  Stream<PlayerModel?> get player$ {
    /// make sure configuration was loaded
    assert(
      _loadedConfiguration,
      'Player service was not loaded, load player using [CurrentPlayerService.load()] at the start of your application',
    );
    _playerSource$ ??= _auth
        .userChanges()

        /// point to player document
        .map((user) => user == null
            ? null
            : _firestore.collection('players').doc(user.uid))

        /// turn document to stream of player snapshots
        .switchMap((doc) => doc == null ? Stream.value(null) : doc.snapshots())

        /// turn snapshot into document data or null
        .map((snapshot) => snapshot?.data())

        /// turn snapshot data into player object, if props found
        .map((data) => data == null ? null : PlayerModel.fromMap(data))
        .shareReplay();

    return _playerSource$!;
  }

  /// get sync access to the current signed in player
  PlayerModel? get currentPlayer {
    /// make sure configuration was loaded
    assert(
      _loadedConfiguration,
      'Player service was not loaded, load player using [CurrentPlayerService.load()] at the start of your application',
    );
    return _player;
  }
}
