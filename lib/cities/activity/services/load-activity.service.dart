import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';

class LoadCityActivitiesService {
  final FirebaseFirestore _firestore;
  LoadCityActivitiesService() : this._firestore = FirebaseFirestore.instance;

  Stream<CityActivityModel> load$() {
    // final payload =
    //     await _fFirestore.collection('application').doc('activities').get();

    // if (!payload.exists) throw new ErrorDescription('activities not found');
    // return CityActivityModel.fromMap(payload.data()!);
    return this
        ._firestore
        .collection('application')
        .doc('activities')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((data) => CityActivityModel.fromMap(data!));
    //    Stream<MonsterModel?> load$(CityDto city) {
    //   return this
    //       ._firestore
    //       .collection('cities')
    //       .doc(city.id)
    //       .collection('pages')
    //       .doc('monster')
    //       .snapshots()
    //       .map((snapshot) => snapshot.data() ?? null)
    //       .map(
    //         (data) => data == null
    //             ? null
    //             : MonsterModel(
    //                 illustration: ImageDto.fromMap(
    //                   data['illustration'],
    //                 ),
    //               ),
    //       );
    // }
  }
}
