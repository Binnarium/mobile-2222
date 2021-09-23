import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class ImageNotSelected implements Exception {}

class ImageNotLoaded implements Exception {}

class ImageNotUploaded implements Exception {}

class UploadImageService {
  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  /// Prompt user to select an image, and upload it to a specific [path]
  ///
  /// - [path] storage location to upload image
  ///
  /// Throws these errors:
  /// - [ImageNotSelected] when an image is not selected
  /// - [ImageNotLoaded] when an image could not be loaded
  /// - [ImageNotUploaded] when an image could not be uploaded to the cloud
  Stream<ImageDto> upload$(String path) {
    return FilePicker.platform
        .pickFiles(
          type: FileType.image,
          allowMultiple: false,
        )
        .asStream()
        .asyncMap<ImageDto>((FilePickerResult? filePickerResult) async {
      if (filePickerResult == null) {
        throw ImageNotSelected();
      }

      // ignore: unnecessary_nullable_for_final_variable_declarations
      final PlatformFile? selectedImage = filePickerResult.files.first;
      if (selectedImage == null) {
        throw ImageNotLoaded();
      }

      try {
        final File imageFile = File(selectedImage.path!);
        final String fileName = selectedImage.name.split('/').last;
        final String uploadPath = '$path/$fileName';

        final Reference uploadRef = _fStorage.ref(uploadPath);
        final UploadTask uploadTask = uploadRef.putFile(imageFile);
        final String url = await uploadTask.then((snapshot) async {
          if (snapshot.state == TaskState.success) {
            return uploadRef.getDownloadURL();
          }
          throw ImageNotUploaded();
        });

        return ImageDto(
          height: 0,
          name: fileName,
          width: 0,
          path: uploadPath,
          url: url,
        );
      } catch (e) {
        throw ImageNotLoaded();
      }
    });
  }
}
