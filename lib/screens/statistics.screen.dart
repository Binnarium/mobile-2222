import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';

class StatisticsScreen extends StatelessWidget {
  static const String route = '/stats';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(backgroundColor: Colors.red),
          Center(
            child: Text('Statistics Page'),
          ),
        ],
      ),
      bottomNavigationBar: Lab2222BottomNavigationBar(
        activePage: Lab2222NavigationBarPages.chat,
      ),
    );
  }
}
