import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/start-video/model/start-video.model.dart';

class LoadStartVideoService {
  final FirebaseFirestore _firestore;
  LoadStartVideoService() : _firestore = FirebaseFirestore.instance;

  Stream<StartVideoModel?> load$() {
    return _firestore
        .collection('application')
        .doc('start-video')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : StartVideoModel.fromMap(data));
  }
}
