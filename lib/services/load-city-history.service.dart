import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-history.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCityHistoryService extends ILoadOptions<CityHistoryDto, CityDto> {
  
  const LoadCityHistoryService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityHistoryDto> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('history')
        .get();

    if (!payload.exists) throw new ErrorDescription('City history not found');
    return CityHistoryDto.fromMap(payload.data()!);
  }
}
