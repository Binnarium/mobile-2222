import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/monster/model/monster.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadMonsterService {
  final FirebaseFirestore _firestore;
  LoadMonsterService() : _firestore = FirebaseFirestore.instance;

  Stream<MonsterModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('monster')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map(
          (data) => data == null
              ? null
              : MonsterModel(
                  illustration: ImageDto.fromMap(
                    data['illustration'] as Map<String, dynamic>,
                  ),
                ),
        );
  }
}
