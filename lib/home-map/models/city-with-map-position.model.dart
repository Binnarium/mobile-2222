import 'package:lab_movil_2222/home-map/models/city.dto.dart';

class CityWithMapPositionModel {
  /// constructor
  CityWithMapPositionModel({
    required this.city,
    required this.top,
    required this.left,
    required this.size,
    this.textOnTop = false,
  })  : assert(top >= 0, 'top needs to be greater than 0'),
        assert(top <= 100, 'top needs to be less than 0'),
        assert(left >= 0, 'left needs to be greater than 0'),
        assert(left <= 100, 'left needs to be less than 0'),
        assert(size >= 0, 'size needs to be greater than 0');

  final CityModel city;
  final int top;
  final int left;
  final int size;
  final bool textOnTop;
}
