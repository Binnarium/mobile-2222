
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab_movil_2222/assets/video/models/better-video.model.dart';
import 'package:lab_movil_2222/shared/pipes/remove-special-characters-string.extension.dart';

const BETTER_VIDEOS_BUCKET = 'gs://video-2222/';

class LoadBetterVideoService {
  LoadBetterVideoService() : _database = FirebaseDatabase.instance;

  final FirebaseStorage _fStorage = FirebaseStorage.instance;
  final FirebaseDatabase _database;

  Stream<BetterVideoModel?> loadFromPath$(String path) {
    final String validPath = path.removeSpecialCharacters();

    return _fStorage
        .refFromURL('$BETTER_VIDEOS_BUCKET/$validPath')
        .list()
        .asStream()
        .asyncMap(
      (listResult) async {
        String? previewUrl = null;
        String? hdUrl = null;
        String? sdUrl = null;

        for (var item in listResult.items) {
          final name = item.name;

          final downloadUrl = await item.getDownloadURL();

          if (name.contains('hd.mp4'))
            hdUrl = downloadUrl;
          else if (name.contains('sd.mp4'))
            sdUrl = downloadUrl;
          else if (name.contains('.jpeg')) previewUrl = downloadUrl;
        }
        return BetterVideoModel(
          hdUrl: hdUrl,
          sdUrl: sdUrl,
          previewUrl: previewUrl,
        );
      },
    );
  }
}
