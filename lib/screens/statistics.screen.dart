import 'package:flutter/material.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class StatisticsScreen extends StatelessWidget {
  static const String route = '/stats';
  @override
  Widget build(BuildContext context) {
    return Scaffold2222.empty(
      body: Stack(
        children: [
          Center(
            child: Text('Statistics Page'),
          ),
        ],
      ),
    );
  }
}
