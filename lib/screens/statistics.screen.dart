import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';

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
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.chat,
      ),
    );
  }
}
