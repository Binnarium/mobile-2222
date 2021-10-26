import 'package:lab_movil_2222/assets/asset.dto.dart';

class FileNotSelected implements Exception {}

class FileNotLoaded implements Exception {}

class FileNotUploaded implements Exception {}

/// Factory class that uploads a file to the Firebase Storage.
/// This class does not updates the Firebase database reference project of the
/// player.
abstract class UploadAssetFactory<FileType extends AssetDto> {
  /// Prompt user to select a file, and upload it to a specific [path]
  ///
  /// - [path] storage location to upload the file
  ///
  /// Throws these errors:
  /// - [FileNotSelected] when an File is not selected
  /// - [FileNotLoaded] when an File could not be loaded
  /// - [FileNotUploaded] when an File could not be uploaded to the cloud
  Stream<FileType> upload$({
    required String path,
  });
}
