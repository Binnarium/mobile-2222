import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-activity.model.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadClubhouseService
    extends ILoadOptions<ClubhouseActivityModel, CityDto> {
  const LoadClubhouseService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<ClubhouseActivityModel> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('clubhouse')
        .get();

    if (!payload.exists) throw new ErrorDescription('City history not found');
    return ClubhouseActivityModel(
      explanation: payload.data()!['explanation'] ?? 'Texto de ejemplo',
      theme: payload.data()!['theme'] ?? 'Texto de ejemplo',
    );
  }
}
