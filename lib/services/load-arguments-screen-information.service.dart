import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';

class LoadArgumentScreenInformationService
    extends ILoadInformationWithOptions<List<String>, CityDto> {
  const LoadArgumentScreenInformationService({
    required final CityDto chapterSettings,
  }) : super(options: chapterSettings);

  @override
  Future<List<String>> load() async {
    final data = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('argument')
        .get();

    if (data.exists) {
      return (data.get('questions') as List<dynamic>)
          .map((e) => e.toString())
          .toList();
    }

    return [];
  }
}
