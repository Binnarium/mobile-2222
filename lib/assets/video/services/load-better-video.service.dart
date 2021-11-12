import 'package:firebase_database/firebase_database.dart';
import 'package:lab_movil_2222/assets/video/models/better-video.model.dart';
import 'package:lab_movil_2222/shared/pipes/remove-special-characters-string.extension.dart';

class LoadBetterVideoService {
  LoadBetterVideoService() : _database = FirebaseDatabase.instance;

  final FirebaseDatabase _database;

  Stream<BetterVideoModel?> loadFromPath$(String path) {
    final String validPath = path.removeSpecialCharacters();
    final DatabaseReference ref =
        _database.reference().child('videos').child(validPath);
    return ref.onValue.map((event) {
      final Map<Object?, Object?>? value =
          event.snapshot.value as Map<Object?, Object?>?;
      if (value == null) return null;
      return BetterVideoModel.fromMap(value.cast<String, dynamic>());
    });
  }
}
