import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class GoalsScreen extends StatelessWidget {
  static const String route = '/goals';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomBackground(backgroundColor: Colors2222.red),
          Center(
            child: Text('Goals Page'),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.page2,
      ),
    );
  }
}
