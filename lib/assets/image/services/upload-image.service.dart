import 'dart:async';
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
      if (filePickerResult == null) throw ImageNotSelected();

      final PlatformFile? selectedImage = filePickerResult.files.first;
      if (selectedImage == null) throw ImageNotLoaded();

      try {
        final File imageFile = File(selectedImage.path!);
        final String fileName = selectedImage.name.split('/').last;
        final String uploadPath = '$path/$fileName';

        final Reference uploadRef = this._fStorage.ref(uploadPath);
        final UploadTask uploadTask = uploadRef.putFile(imageFile);
        final String url = await uploadTask.then((snapshot) async {
          if (snapshot.state == TaskState.success)
            return await uploadRef.getDownloadURL();
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

// /// to upload a file
// Future<String> uploadMultimediaFile(File file, String kind) async {
//   String urlDownload = "";

//   final destination =
//       'chats/${this.widget.chat.id}/files/${file.path.split("/").last}';
//   print("LOCATION: $destination");

//   UploadTask? task = UploadFileToFirebaseService.uploadFile(destination, file);

//   if (task == null) return "";

//   final snapshot = await task;

//   urlDownload = await snapshot.ref.getDownloadURL();

//   print('Download link: $urlDownload');
//   return urlDownload;
// }

// // Future<File> selectMultimediaFile(String kind) async {
// //   /// allowed extensions depending on file kind
// //   Map<String, List<String>> allowedExtensions = {
// //     'MESSAGE#IMAGE': ['png', 'svg', 'jpg', 'jpeg'],
// //     'MESSAGE#VIDEO': ['mp4', 'avi', 'wmv', 'amv', 'm4v', 'gif']
// //   };
// //   final result = await FilePicker.platform.pickFiles(
// //       type: FileType.custom,
// //       allowMultiple: false,
// //       allowedExtensions: allowedExtensions[kind]);

// //   if (result == null) return File('');

// //   /// to get the path of the file
// //   final path = result.files.single.path!;

// //   return File(path);
// // }