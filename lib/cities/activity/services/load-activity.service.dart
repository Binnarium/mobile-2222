import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';

class LoadCityActivitiesService {
  final FirebaseFirestore _firestore;
  LoadCityActivitiesService() : _firestore = FirebaseFirestore.instance;

  Stream<CityActivityModel?> load$() {
    return _firestore
        .collection('application')
        .doc('activities')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : CityActivityModel.fromMap(data));
  }
}
