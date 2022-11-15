import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:lab_movil_2222/assets/asset.dto.dart';
import 'package:lab_movil_2222/assets/upload-asset.factory.dart';

class UploadPdfService extends UploadAssetFactory<PdfDto> {
  final FirebaseStorage _fStorage = FirebaseStorage.instance;

  @override
  Stream<PdfDto> upload$({required String path}) {
    return FilePicker.platform
        .pickFiles(
          /// TESTING
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: ['pdf'],
        )
        .asStream()
        .asyncMap<PdfDto>(
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
              final String fileName = selectedFile.name.split('/').last;
              final String uploadPath = '$path/$fileName';
              final Reference uploadRef = _fStorage.ref(uploadPath);

              UploadTask uploadTask;
              final Uint8List? projectFile = selectedFile.bytes;

              /// method with bites
              if (projectFile != null) {
                uploadTask = uploadRef.putData(projectFile);
              }

              /// error fallback
              else {
                throw FileNotLoaded();
              }

              final String url = await uploadTask.then((snapshot) async {
                if (snapshot.state == TaskState.success) {
                  return uploadRef.getDownloadURL();
                }
                throw FileNotUploaded();
              });
              return PdfDto(
                name: fileName,
                path: uploadPath,
                url: url,
              );
            } catch (e) {
              print(e);
              throw FileNotLoaded();
            }
          },
        );
  }
}
