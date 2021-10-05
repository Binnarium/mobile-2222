import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';

class NextPhaseVideoScreen extends StatefulWidget {
  const NextPhaseVideoScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/next-phase-video';
  final CityModel city;

  @override
  State<NextPhaseVideoScreen> createState() => _NextPhaseVideoScreenState();
}

class _NextPhaseVideoScreenState extends State<NextPhaseVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold2222.city(
        body: const Center(
          child: Text('next-phase screen'),
        ),
        city: widget.city,
        route: NextPhaseVideoScreen.route);
  }
}
