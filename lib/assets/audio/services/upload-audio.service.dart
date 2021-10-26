import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab_movil_2222/assets/asset.dto.dart';
import 'package:lab_movil_2222/assets/upload-asset.factory.dart';

class UploadAudioService extends UploadAssetFactory<AudioDto> {
  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  @override
  Stream<AudioDto> upload$({
    required String path,
  }) {
    return FilePicker.platform
        .pickFiles(
          type: FileType.audio,
          allowMultiple: false,
        )
        .asStream()
        .asyncMap<AudioDto>(
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
          return AudioDto(
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
