import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class VideoNotSelected implements Exception {}

class VideoNotLoaded implements Exception {}

class VideoNotUploaded implements Exception {}

class UploadVideoService {
  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  /// Prompt user to select an image, and upload it to a specific [path]
  ///
  /// - [path] storage location to upload image
  ///
  /// Throws these errors:
  // ignore: comment_references
  /// - [ImageNotSelected] when an image is not selected
  // ignore: comment_references
  /// - [ImageNotLoaded] when an image could not be loaded
  // ignore: comment_references
  /// - [ImageNotUploaded] when an image could not be uploaded to the cloud
  Stream<VideoDto> upload$(String path) {
    return FilePicker.platform
        .pickFiles(
          type: FileType.video,
          allowMultiple: false,
        )
        .asStream()
        .asyncMap<VideoDto>((FilePickerResult? filePickerResult) async {
      if (filePickerResult == null) {
        throw VideoNotSelected();
      }

      // ignore: unnecessary_nullable_for_final_variable_declarations
      final PlatformFile? video = filePickerResult.files.first;
      if (video == null) {
        throw VideoNotLoaded();
      }

      try {
        final File videoFile = File(video.path!);
        final String fileName = video.name.split('/').last;
        final String uploadPath = '$path/$fileName';

        final Reference uploadRef = _fStorage.ref(uploadPath);
        final UploadTask uploadTask = uploadRef.putFile(videoFile);
        final String url = await uploadTask.then((snapshot) async {
          if (snapshot.state == TaskState.success) {
            return uploadRef.getDownloadURL();
          }
          throw VideoNotUploaded();
        });

        return VideoDto(
          duration: 0,
          name: fileName,
          format: '',
          path: uploadPath,
          url: url,
        );
      } catch (e) {
        throw VideoNotLoaded();
      }
    });
  }
}
