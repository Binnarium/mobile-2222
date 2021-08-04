import 'package:lab_movil_2222/shared/models/city.dto.dart';

class CityWithMapPositionDto {
  final CityDto city;
  final int top;
  final int left;
  final int size;

  CityWithMapPositionDto({
    required this.city,
    required this.top,
    required this.left,
    required this.size,
  })  : assert(top >= 0, 'top needs to be greater than 0'),
        assert(top <= 100, 'top needs to be less than 0'),
        assert(left >= 0, 'left needs to be greater than 0'),
        assert(left <= 100, 'left needs to be less than 0'),
        assert(size >= 0, 'size needs to be greater than 0');
}
