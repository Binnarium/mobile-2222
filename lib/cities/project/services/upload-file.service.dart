import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';

class FileNotSelected implements Exception {}

class FileNotLoaded implements Exception {}

class FileNotUploaded implements Exception {}

/// Class that uploads a file to the Firebase Storage.
/// This class does not updates the Firebase database reference project of the
/// player. For that, implement UploadProjectService
class UploadFileService {
  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  /// Prompt user to select a pdf, and upload it to a specific [path]
  ///
  /// - [path] storage location to upload the pdf
  ///
  /// Throws these errors:
  /// - [FileNotSelected] when an File is not selected
  /// - [FileNotLoaded] when an File could not be loaded
  /// - [FileNotUploaded] when an File could not be uploaded to the cloud
  Stream<ProjectFileDto> uploadFile$(String path, ProjectDto dto) {
    return FilePicker.platform
        .pickFiles(
          /// TESTING
          type: (dto.allowAudio) ? FileType.audio : FileType.custom,
          allowMultiple: false,
          allowedExtensions: (dto.allowAudio) ? [] : ['pdf'],
        )
        .asStream()
        .asyncMap<ProjectFileDto>(
      (FilePickerResult? filePickerResult) async {
        if (filePickerResult == null) {
          throw FileNotSelected();
        }

        PlatformFile? selectedFile;
        selectedFile = filePickerResult.files.first;
        if (selectedFile == null) {
          throw FileNotLoaded();
        }

        try {
          final File projectFile = File(selectedFile.path!);
          final String fileName = selectedFile.name.split('/').last;
          final String uploadPath = '$path/$fileName';

          final Reference uploadRef = _fStorage.ref(uploadPath);
          final UploadTask uploadTask = uploadRef.putFile(projectFile);
          final String url = await uploadTask.then((snapshot) async {
            if (snapshot.state == TaskState.success) {
              return uploadRef.getDownloadURL();
            }
            throw FileNotUploaded();
          });
          return ProjectFileDto(
            name: fileName,
            path: uploadPath,
            url: url,
          );
        } catch (e) {
          throw FileNotLoaded();
        }
      },
    );
  }
}
